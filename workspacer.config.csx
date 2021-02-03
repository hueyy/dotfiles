#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"

using System;
using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;

using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Timers;
using System.Windows.Forms;

public class BatteryWidget : BarWidgetBase
{
    public Color LowChargeColor { get; set; } = Color.Red;
    public bool HasBatteryWarning { get; set; } = true;
    public double LowChargeThreshold { get; set; } = 0.25;
    public int Interval { get; set; } = 5000;

    private System.Timers.Timer _timer;

    public override IBarWidgetPart[] GetParts()
    {
        PowerStatus pwr = SystemInformation.PowerStatus;
        float CurrentBatteryCharge = pwr.BatteryLifePercent;

        if (HasBatteryWarning)
        {
            if (CurrentBatteryCharge <= LowChargeThreshold)
            {
                return Parts(Part(CurrentBatteryCharge.ToString("#0%"), LowChargeColor));
            }
            else
            {
                return Parts(Part(CurrentBatteryCharge.ToString("#0%")));
            }
        }
        else
        {
            return Parts(CurrentBatteryCharge.ToString("#0%"));
        }
    }

    public override void Initialize()
    {
        _timer = new System.Timers.Timer(Interval);
        _timer.Elapsed += (s, e) => Context.MarkDirty();
        _timer.Enabled = true;
    }
}

Action<IConfigContext> doConfig = (context) =>
{
	var titleWidget = new TitleWidget();
	titleWidget.MonitorHasFocusColor = Color.White;
	
    context.AddBar(new BarPluginConfig(){
		BarTitle = "workspacer.Bar",
		BarHeight = 30,
		FontSize = 12,
		FontName = "Iosevka",
		LeftWidgets = () => new IBarWidget[] { new WorkspaceWidget(), new TextWidget("   "), titleWidget },
		RightWidgets = () => new IBarWidget[] { new BatteryWidget(), new TextWidget(" "), new TimeWidget(1000, "ddd dd/M/yyyy | h:mm:tt"), new TextWidget(" "), new ActiveLayoutWidget() }
	});
    context.AddFocusIndicator();
    var actionMenu = context.AddActionMenu();

    context.WorkspaceContainer.CreateWorkspaces("main", "ref", "comms", "browser", "five");
	
	context.WindowRouter.AddRoute((window) => 
		(
			window.Title.Contains("Telegram") ||
			window.Title.Contains("Messenger") ||
			window.Title.Contains("Teams")
		) ? context.WorkspaceContainer["comms"] : null
	);
	
	context.WindowRouter.AddFilter((w) =>
		!w.Title.Contains("Snip")  &&
		!w.Title.Contains("Save as") &&
		!w.Title.Contains("User Account Control") &&
		!w.Title.Contains("UAC") &&
		!w.Title.Contains("Volume Mixer") &&
		!w.Title.Contains("Cisco AnyConnect") &&
		!w.Title.Contains("Picture in picture") &&
		!w.ProcessName.Contains("setup") &&
		!w.ProcessName.Contains("steam") &&
		!w.Title.Contains("Installing") &&
		!w.Title.Contains("Installer") &&
		!w.Title.Contains("Media viewer") &&
		!w.ProcessName.Contains("alacritty") &&
		!w.Title.Contains("Microsoft Teams") &&
		!w.Title.Contains("Messenger") &&
		!w.ProcessName.Contains("Bitwarden") &&
		!w.Title.Contains("Quick Format Citation") && // Zotero / Juris-M MSWord dialog
		w.Class != "#32770" && // vscode confirmation dialog
		w.Class != "OperationStatusWindow" && // explorer.exe move/copy/delete
		!(
			(w.Class == "Qt5QWindowIcon" || w.Class == "Qt5QWindowOwnDC") &&
			w.Title.Contains("Nextcloud")
		) // nextcloud
	);
};
return doConfig;
