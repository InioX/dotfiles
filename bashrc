if ! pgrep -f crond >/dev/null; then
echo [Starting crond...] && crond && echo [OK]
else
echo [crond is running]
fi

