@ECHO OFF
msbuild
if ERRORLEVEL 1 goto :EOF
packages\Machine.Specifications.0.8.1\tools\mspec-clr4.exe bin\Debug\EPiCommerce.Integration.Sample.dll
