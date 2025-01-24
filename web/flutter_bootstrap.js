/* prettier-ignore */
{{flutter_js}}
/* prettier-ignore */
{{flutter_build_config}}

async function loadTemplate(name) {
  const response = await fetch(`/views/${name}.html`);
  const html = await response.text();
  const div = document.createElement("div");
  div.innerHTML = html;
  return div.querySelector("template");
}

function createDeepLink(path = "") {
  const baseScheme = "ukhsc-mobile-app://";
  return `${baseScheme}${path || `${location.pathname}${location.search}`}`;
}

async function callbackHandler(searchParams) {
  const callbackView = document.getElementById("native-callback-view");
  if (!callbackView) return;

  try {
    const template = await loadTemplate("callback-view");
    const isSuccess = searchParams.has("code");
    callbackView.innerHTML = "";

    const templateToUse = isSuccess ? template : template.nextElementSibling;
    if (!templateToUse) return;

    const content = templateToUse.content.cloneNode(true);
    callbackView.appendChild(content);

    const deepLink = isSuccess
      ? createDeepLink()
      : createDeepLink("/auth/school");

    const openAppBtn = document.getElementById("openAppBtn");
    if (openAppBtn) {
      openAppBtn.addEventListener("click", () => {
        window.location.href = deepLink;
      });
    }

    if (!isSuccess) return;
    let countdown = 5;
    const countdownElement = document.getElementById("countdown");
    if (countdownElement) {
      const timer = setInterval(() => {
        countdown--;
        countdownElement.textContent = countdown;
        if (countdown <= 0) {
          clearInterval(timer);
          window.location.href = deepLink;
        }
      }, 1000);
    }
  } catch (error) {
    console.error("Callback Error:", error);
  }
}

async function initializeSplashView() {
  const splashTemplate = await loadTemplate("splash-view");
  const splashView = document.getElementById("splash-view");
  if (splashView && splashTemplate) {
    const content = splashTemplate.content.cloneNode(true);
    splashView.appendChild(content);
    const messageElement = splashView.querySelector("#splash-message");
    if (messageElement) {
      messageElement.innerHTML = "U 型叉正在尋找它的堡寶";
    }
  }
}

async function initializeFlutter() {
  await initializeSplashView();
  _flutter.loader.load({
    onEntrypointLoaded: async function (engineInitializer) {
      const appRunner = await engineInitializer.initializeEngine();
      await appRunner.runApp();
      document.getElementById("splash-view")?.remove();
    },
  });
}

function shouldShowIOSInstallGuide() {
  if (window.navigator.standalone) return false;

  const closeCount = parseInt(
    localStorage.getItem("installGuideCloseCount") || "0"
  );
  if (closeCount >= 4) return false;

  if (closeCount === 0) return true;
  const chance = 1 / (closeCount + 1);
  return Math.random() < chance;
}

async function showIOSInstallGuide() {
  if (!shouldShowIOSInstallGuide()) return;

  try {
    const template = await loadTemplate("ios-install-guide");
    if (!template) return;

    const guide = template.content.cloneNode(true);
    document.body.appendChild(guide);

    const overlay = document.getElementById("guide-overlay");
    const guideContainer = document.getElementById("ios-guide-container");
    const showGuideBtn = document.getElementById("show-guide-btn");
    const closeGuideBtn = document.getElementById("close-guide-btn");
    const closeOverlayBtn = document.getElementById("close-overlay-btn");

    if (!overlay || !guideContainer || !showGuideBtn || !closeGuideBtn) return;

    const showOverlay = () => {
      overlay.classList.remove("pointer-events-none");
      overlay.classList.add("opacity-100");
      overlay.style.backgroundColor = "rgba(0, 0, 0, 0.7)";
      overlay.style.display = "flex";
    };

    const hideOverlay = () => {
      overlay.classList.add("pointer-events-none");
      overlay.classList.remove("opacity-100");
      overlay.style.backgroundColor = "transparent";
      setTimeout(() => {
        overlay.style.display = "none";
      }, 300);

      localStorage.setItem("hasShownInstallGuide", "true");
    };

    const removeGuide = () => {
      const guide = document.querySelector(".ios-install-guide");
      if (guide) guide.remove();

      const closeCount = parseInt(
        localStorage.getItem("installGuideCloseCount") || "0"
      );
      console.log("Close count:", closeCount);
      localStorage.setItem(
        "installGuideCloseCount",
        (closeCount + 1).toString()
      );
    };

    showGuideBtn.addEventListener("click", showOverlay);
    closeGuideBtn.addEventListener("click", removeGuide);
    closeOverlayBtn?.addEventListener("click", () => {
      hideOverlay();
      localStorage.setItem("hasShownInstallGuide", "true");
    });
    overlay.addEventListener("click", (e) => {
      if (e.target === overlay) hideOverlay();
    });
  } catch (error) {
    console.error("Error showing iOS guide:", error);
  }
}

function isIOSDevice() {
  return /iPad|iPhone|iPod/.test(navigator.userAgent);
}

function isSafariBrowser() {
  return (
    /Safari/.test(navigator.userAgent) && !/Chrome/.test(navigator.userAgent)
  );
}

async function handleDeviceNotSupported() {
  const container = document.getElementById("device-not-supported-view");
  if (!container) return;
  const template = await loadTemplate("device-not-supported");
  if (template) container.appendChild(template.content.cloneNode(true));
}

async function detectDeviceAndProceed() {
  const isMobilePortrait =
    window.innerWidth <= 480 && window.innerHeight > window.innerWidth;

  if (!isMobilePortrait) {
    await handleDeviceNotSupported();
    return false;
  }

  if (isIOSDevice() && isSafariBrowser() && !window.navigator.standalone) {
    await showIOSInstallGuide();
  }
  return true;
}

document.addEventListener("DOMContentLoaded", async () => {
  try {
    await screen.orientation?.lock?.("portrait").catch(() => {});
    const isDeviceSupported = await detectDeviceAndProceed();
    if (!isDeviceSupported) return;

    const isCallback = location.pathname.startsWith("/auth/callback/");
    const searchParams = new URLSearchParams(location.search);
    const state = searchParams.has("state")
      ? JSON.parse(searchParams.get("state"))
      : null;

    if (isCallback && state?.is_native_app) {
      callbackHandler(searchParams);
    } else {
      initializeFlutter();
    }
  } catch (error) {
    console.error("Bootstrap Error:", error);
  }
});
