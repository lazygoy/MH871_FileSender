# Contributing

Bug reports, testing notes, and code improvements are welcome.

## Useful test information

Please include the exact MH-871 model, Windows version, USB hardware IDs, file size, and complete error output. State clearly whether the issue is device detection, opening the USB interface, writing data, or cutter interpretation.

## Safety

Do not test unverified motion commands with the blade engaged. Do not add a software pause/stop feature unless its behavior has been verified against the hardware.

## Code changes

Keep the application compatible with Windows PowerShell 5.1 unless there is a documented reason to change that requirement. Avoid adding driver replacement or kernel-mode components.
