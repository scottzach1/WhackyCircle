# Whacky-Circle
Whack-a-mole style, circle clicker

## Setup

1. Clone the project (change in project name)

```bash
git clone git@github.com:scottzach1/WhackyCircle.git
git clone https://github.com/scottzach1/WhackyCircle.git
```
2. Open the project in vscode `code WhackyCircle`

3. Install the extension [Processing Language](https://marketplace.visualstudio.com/items?itemName=Tobiah.language-pde) by Tobiah Zarlez

4. Run the project via `Ctrl + Shift + B`

### Errors

Depending on your environment, you may experience the following error when you attempt to run the project:

```
Picked up _JAVA_OPTIONS: -Dawt.useSystemAAFontSettings=gasp
-Djava.ext.dirs=/usr/share/processing/java/lib/ext is not supported.  Use -classpath instead.
Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit.
```

This can be resolved by editing the file `/usr/bin/processing-java`. Edit the `_JAVA_OPTIONS` variable and omit the following: `-Djava.ext.dirs=/usr/share/processing/java/lib/ext`.

Thanks to [onibrow](https://github.com/onibrow) for mentioning the fix [here](https://github.com/onibrow/arg-calibration).