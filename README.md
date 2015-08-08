# Open Terminal Here

Open the Terminal (Mac OS X, Linux) or Command Prompt (Windows)
in the given directory via context menu or keyboard shortcut.

Platform | Keyboard shortcut
-------- | -----------------
Mac OS X | `ctrl-cmd-t`
Windows  | `ctrl-shift-t`
Linux    | `ctrl-shift-t`

![Screenshot of the "Open Terminal Here" menu item displayed][1]

## FAQ

### How to open a new tab instead of a new window (Mac OS X)?

1. Open [Automator][2] and select `Application` as new document.
2. From the Library, add `Run Applescript` as Automator action.
3. Replace the sample AppleScript code with the code from [this script][3].
4. Save the Automator app as `TerminalTab.app` to your Applications folder.
5. In the `open-terminal-here` settings, set `App` to `TerminalTab.app`.

[1]: https://raw.githubusercontent.com/blueimp/atom-open-terminal-here/master/screenshot.png
[2]: https://en.wikipedia.org/wiki/Automator_(software)
[3]: https://github.com/blueimp/atom-open-terminal-here/blob/master/open-terminal-tab.scpt
