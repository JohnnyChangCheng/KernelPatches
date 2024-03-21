
adb install -g -r Facebook_453.0.0.0.10_apkcombo.com.apk
adb install -g -r Instagram_320.0.0.0.7_apkcombo.com.apk
adb install -g -r maplestory.apk
adb install -g -r TikTok_33.6.3_apkcombo.com.apk
adb install -g -r X_10.29.0-release.0_Apkpure.apk
adb install -g -r whatsapp.apk
adb install -g -r waze.apk

mark_page_accessed

# ColdStart -S

adb shell "setprop sys.lmk.minfree_levels 0:0,0:100,0:200,0:250,0:900,0:950"
adb shell "echo 200 > /proc/sys/vm/swappiness"
adb shell settings put system screen_off_timeout 60000

adb shell "am start -W -n com.zhiliaoapp.musically/com.ss.android.ugc.aweme.splash.SplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.facebook.katana/.LoginActivity  -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.nexon.maplem.global/com.nexon.maplem.module.MapleUnityActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.twitter.android/com.twitter.onboarding.ocf.signup.SignUpSplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.instagram.android/com.instagram.mainactivity.InstagramMainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.whatsapp/com.whatsapp.registration.EULA -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.waze/com.waze.MainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5





adb shell "cat /proc/$(adb shell pgrep -o -f com.instagram.android)/maps" > instagram.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.instagram.android)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> instagram.txt

adb shell "cat /proc/$(adb shell pgrep -o -f com.nexon.maplem.global)/maps" > maplestory.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.nexon.maplem.global)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> maplestory.txt

adb shell "cat /proc/$(adb shell pgrep -o -f com.facebook.katana)/maps" > facebook.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.facebook.katana)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> facebook.txt

adb shell "cat /proc/$(adb shell pgrep -o -f com.twitter.android)/maps" > twitter.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.twitter.android)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> twitter.txt

adb shell "cat /proc/$(adb shell pgrep -o -f com.whatsapp)/maps" > whatsapp.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.whatsapp)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> whatsapp.txt

adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/maps" > tiktok.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/stat" | awk '{print "Anon faults:", $10, "\nFile faults:", $12}' > tiktok_faults.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/smaps" > tiktok_smaps.txt


adb shell "cat /proc/$(adb shell pgrep -o -f com.waze)/maps" > waze.txt
adb shell "cat /proc/$(adb shell pgrep -o -f com.waze)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' >> waze.txt

 

adb shell settings put system screen_off_timeout 60000

adb shell "setprop sys.lmk.minfree_levels 0:0,0:100,0:200,0:250,0:900,0:950"
adb shell settings put system screen_off_timeout 60000
adb shell "echo 200 > /proc/sys/vm/swappiness"

adb shell "/data/stressapptest -M 1024 -s 120000"


for ((i=1; i<=20; i++))
do
    adb shell "am start -W -n com.facebook.katana/.LoginActivity  -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
    sleep 5
	adb shell "am start -W -n com.nexon.maplem.global/com.nexon.maplem.module.MapleUnityActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.whatsapp/com.whatsapp.registration.EULA -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.instagram.android/com.instagram.mainactivity.InstagramMainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.waze/com.waze.MainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.twitter.android/com.twitter.onboarding.ocf.signup.SignUpSplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
    adb shell "am start -W -n com.zhiliaoapp.musically/com.ss.android.ugc.aweme.splash.SplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN" > "tiktok${i}_launch.txt"
    sleep 5
    adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/maps" > "tiktok${i}.txt"
    adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' > "tiktok${i}_fault.txt"
done


for ((i=1; i<=20; i++))
do
	adb shell "am start -W -n com.facebook.katana/.LoginActivity  -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.nexon.maplem.global/com.nexon.maplem.module.MapleUnityActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.whatsapp/com.whatsapp.registration.EULA -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.zhiliaoapp.musically/com.ss.android.ugc.aweme.splash.SplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
    sleep 5
    adb shell "am start -W -n com.twitter.android/com.twitter.onboarding.ocf.signup.SignUpSplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.instagram.android/com.instagram.mainactivity.InstagramMainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.waze/com.waze.MainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN" > "waze${i}_launch.txt"
	sleep 5
	adb shell "cat /proc/$(adb shell pgrep -o -f com.waze)/maps" > "waze${i}.txt"
	adb shell "cat /proc/$(adb shell pgrep -o -f com.waze)/smaps" > "waze_smap${i}.txt"
	adb shell "cat /proc/$(adb shell pgrep -o -f com.waze)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' > "waze${i}_fault.txt"
	adb shell "dumpsys gfxinfo $(adb shell pgrep -o -f com.waze)" | grep Janky > "waze${i}_janky.txt"
done

for ((i=1; i<=20; i++))
do
	adb shell "am start -W -n com.nexon.maplem.global/com.nexon.maplem.module.MapleUnityActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.whatsapp/com.whatsapp.registration.EULA -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.zhiliaoapp.musically/com.ss.android.ugc.aweme.splash.SplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
    sleep 5
    adb shell "am start -W -n com.twitter.android/com.twitter.onboarding.ocf.signup.SignUpSplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.instagram.android/com.instagram.mainactivity.InstagramMainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.waze/com.waze.MainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
	adb shell "am start -W -n com.facebook.katana/.LoginActivity  -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
	sleep 5
done


	adb shell "cat /proc/$(adb shell pgrep -o -f com.facebook.katana)/maps" > "fb${i}.txt"
	adb shell "cat /proc/$(adb shell pgrep -o -f com.facebook.katana)/smaps" > "fb${i}_smaps.txt"
	adb shell "cat /proc/$(adb shell pgrep -o -f com.facebook.katana)/stat" | awk '{print "Minor faults:", $10, "\nMajor faults:", $12}' > "fb${i}_fault.txt"
	adb shell "dumpsys gfxinfo $(adb shell pgrep -o -f com.facebook.katana)" | grep Janky > "fb${i}_janky.txt"

get_total_cpu_time() {
    cat /proc/stat | grep '^cpu ' | awk '{print $2+$3+$4+$5+$6+$7+$8}'
}

# Function to get CPU idle time
get_idle_cpu_time() {
    cat /proc/stat | grep '^cpu ' | awk '{print $5}'
}

# Calculate CPU usage percentage
calculate_cpu_usage() {
    total_cpu_time1=$(get_total_cpu_time)
    idle_cpu_time1=$(get_idle_cpu_time)
    sleep 1
    total_cpu_time2=$(get_total_cpu_time)
    idle_cpu_time2=$(get_idle_cpu_time)

    total_cpu_time_diff=$((total_cpu_time2 - total_cpu_time1))
    idle_cpu_time_diff=$((idle_cpu_time2 - idle_cpu_time1))

    cpu_usage=$((100 * (total_cpu_time_diff - idle_cpu_time_diff) / total_cpu_time_diff))
    echo "CPU Usage: $cpu_usage%"
}

# Call function to calculate CPU usage
calculate_cpu_usage



fastboot flash boot        boot.img
fastboot flash dtbo        dtbo.img
fastboot flash vendor_kernel_boot vendor_kernel_boot.img
fastboot reboot fastboot
fastboot flash vendor_dlkm vendor_dlkm.img
fastboot reboot



# Monitor tiktok vma status
adb shell "echo $(adb shell pgrep -o -f com.zhiliaoapp.musically) > /sys/devices/platform/memory_profile/vma_fault"

adb shell "am start -W -n com.nexon.maplem.global/com.nexon.maplem.module.MapleUnityActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.whatsapp/com.whatsapp.registration.EULA -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.zhiliaoapp.musically/com.ss.android.ugc.aweme.splash.SplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.twitter.android/com.twitter.onboarding.ocf.signup.SignUpSplashActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.instagram.android/com.instagram.mainactivity.InstagramMainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.waze/com.waze.MainActivity -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5
adb shell "am start -W -n com.facebook.katana/.LoginActivity  -c android.intent.category.LAUNCHER -a android.intent.action.MAIN"
sleep 5

adb shell "rm -rf /data/local/tmp/*.txt"
adb shell cat /sys/devices/platform/memory_profile/vma_fault
adb pull "/data/local/tmp/$(adb shell pgrep -o -f com.zhiliaoapp.musically).txt" tiktok_vma.txt 
adb shell "cat /proc/$(adb shell pgrep -o -f com.zhiliaoapp.musically)/smaps" > "tiktok_smaps.txt"
