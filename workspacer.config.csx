#r "C:\Program Files\workspacer\workspacer.Shared.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Bar\workspacer.Bar.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.ActionMenu\workspacer.ActionMenu.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.FocusIndicator\workspacer.FocusIndicator.dll"
#r "C:\Program Files\workspacer\plugins\workspacer.Gap\workspacer.Gap.dll"

using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Timers;
using System.Windows.Forms;

using workspacer;
using workspacer.Bar;
using workspacer.Bar.Widgets;
using workspacer.ActionMenu;
using workspacer.FocusIndicator;
using workspacer.Gap;

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

  context.WorkspaceContainer.CreateWorkspaces("main", "ref", "comms", "browser", "other");
  
  context.WindowRouter.AddRoute((window) => 
    (
      window.ProcessName == "Obsidian.exe" ||
      window.ProcessName == "Code.exe" // vscode
    ) ? context.WorkspaceContainer["main"] : null
  );

  context.WindowRouter.AddRoute((window) =>
    (
      window.ProcessName == "Acrobat.exe" ||
      window.ProcessName == "PDFXEdit.exe"
    ) ? context.WorkspaceContainer["ref"] : null
  );

  context.WindowRouter.AddRoute((window) => 
    (
      window.Title.Contains("Telegram") ||
      window.Title.Contains("Messenger") ||
      window.Title.Contains("Microsoft Teams") ||
      window.ProcessName.Contains("Unigram") ||
      window.ProcessName.Contains("WhatsApp")
    ) ? context.WorkspaceContainer["comms"] : null
  );

  context.WindowRouter.AddRoute((window) =>
    (
      window.ProcessName == "Firefox.exe"
    ) ? context.WorkspaceContainer["browser"] : null
  );

  context.WindowRouter.AddRoute((window) =>
    (
      window.ProcessName == "Zoom.exe" ||
      window.ProcessName == "zWebview2Agent.exe"
      ? context.WorkspaceContainer["other"] : null
    )
  );
  
  context.WindowRouter.AddFilter((w) =>
    !(w.ProcessName == "SyncTrayzor.exe") &&
    !(w.ProcessName == "Tabby.exe") && 
    !(w.ProcessName == "vcxsrv.exe") &&
    !(w.ProcessName == "XWin_MobaX.exe") &&
    !(w.Title == "Bingsu") &&
    !w.ProcessName.Contains("alacritty") &&
    !w.ProcessName.Contains("Bitwarden") &&
    !w.ProcessName.Contains("Microsoft.WindowsCalculator") &&
    !w.ProcessName.Contains("setup") &&
    !w.ProcessName.Contains("Spotify") &&
    !w.ProcessName.Contains("steam") &&
    !w.Title.Contains("Cisco AnyConnect") &&
    !w.Title.Contains("Installer") &&
    !w.Title.Contains("Installing") &&
    !w.Title.Contains("Media viewer") &&
    !w.Title.Contains("Messenger") &&
    !w.Title.Contains("Microsoft Teams") &&
    !w.Title.Contains("Picture in picture") &&
    !w.Title.Contains("Quick Format Citation") && // Zotero / Juris-M MSWord dialog
    !w.Title.Contains("Save as") &&
    !w.Title.Contains("Snip")  &&
    !w.Title.Contains("UAC") &&
    !w.Title.Contains("User Account Control") &&
    !w.Title.Contains("Volume Mixer") &&
    w.Class != "#32770" && // vscode confirmation dialog
    w.Class != "OperationStatusWindow" && // explorer.exe move/copy/delete
    !(
      (w.Class == "Qt5QWindowIcon" || w.Class == "Qt5QWindowOwnDC") &&
      w.Title.Contains("Nextcloud")
    ) // nextcloud
  );
};
return doConfig;
