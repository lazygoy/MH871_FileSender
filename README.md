# USCutter MH-871 File Sender

A small Windows utility for sending HPGL/PLT files directly to a USCutter MH-871 through its existing Microsoft USB printer driver.

**No Inkscape integration. No speed or blade-pressure controls.** Export an HPGL/PLT file from your design software, select it, and send it to the cutter. Speed and blade pressure remain controlled by the cutter itself.

> **Project status: early experimental release (0.1.0).** This software has successfully cut large complex files on my test machine, your results may differ.

## Features

- Detects the MH-871 using USB printer interface discovery.
- Uses the existing Windows `usbprint` driver; it does not install or replace drivers.
- Opens `.hpgl` and `.plt` files and sends their bytes without translating or scaling them.
- Confirms the filename and byte count before transmission.
- Reports Windows write success or an error.
- Keeps speed and blade pressure on the cutter's own controls.

## Requirements

- USCutter MH-871 connected by USB and powered on.
- Windows 10 or Windows 11.
- Windows PowerShell 5.1.
- The Microsoft USB printer driver supplied by Windows.
- An HPGL/PLT file exported by your design software.

The current implementation is a PowerShell 5.1 Windows Forms application. It does not require Python, .NET SDK installation, or a third-party driver.

## Run it

1. Download or clone this repository.
2. Connect and power on the MH-871.
3. Double-click `Run-MH871-File-Sender.bat`.
4. Confirm the window reports **MH-871 detected and ready**.
5. Browse to an `.hpgl` or `.plt` file.
6. Load the material and confirm the cutter is ready.
7. Click **Send to Cutter** and confirm the transmission.

If Windows blocks the script, open Windows PowerShell in the project folder and run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File .\src\MH871-File-Sender.ps1
```

The bypass applies only to that process invocation. It does not change the machine-wide PowerShell execution policy.

## Safety and limitations

- The sender transmits the file as-is. It does not inspect, preview, scale, rotate, or translate HPGL commands.
- Check the design's dimensions and origin in your design software before sending.
- Test unfamiliar files with the blade lifted or removed and scrap material loaded.
- Keep hands, cables, and loose material clear of the carriage and feed rollers.
- A successful Windows write means Windows accepted the bytes. It does **not** prove that the cutter interpreted every command or completed the cut.
- There is no pause, cancel, or emergency-stop feature. Use the cutter's physical controls for emergencies.
- The app currently reads the entire file into memory and sends it in one write operation. Very large files and long production jobs need further testing.
- The project has been tested on one reported MH-871 setup. Other USCutter models, USB IDs, firmware revisions, and Windows configurations may behave differently.

## Known tested hardware

Reported test setup:

- Model: USCutter MH-871
- USB VID/PID: `7447:5419`
- Windows device service: `usbprint`
- Windows driver: Microsoft USB printer driver
- USB printer interface GUID: `28D78FAD-5A12-11D1-AE5B-0000F803A8C2`

## Repository layout

```text
MH871-File-Sender/
├── src/
│   └── MH871-File-Sender.ps1
├── docs/
│   └── PROTOCOL-NOTES.md
├── examples/
│   └── README.md
├── Run-MH871-File-Sender.bat
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Building / packaging

The application currently runs directly as a PowerShell script, so there is no compile step required. The `.bat` launcher starts it in STA mode, which Windows Forms requires.

A standalone `.exe` wrapper may be added later, but it should not be treated as necessary for operation. Before publishing an executable, validate the sender with complete HPGL files on the target cutter and document exactly how the executable was built.

## Reporting issues

When reporting a problem, include:

- Windows version.
- Exact cutter model and USB VID/PID (Device Manager → device Properties → Details → Hardware Ids).
- Whether the app detects the cutter.
- File extension and approximate file size.
- The complete error text.

Do not post private documents or unrelated USB captures. If sharing a USB capture, inspect it first for device identifiers or unrelated traffic.

## License

