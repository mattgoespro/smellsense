<!DOCTYPE html>
<html>
<style>
    :root {
        --blue: #00a6e4;
    }

    body {
        font-family: Roboto;
        color: black;
        font-size: 24px;
    }

    .main {
        background: white;
        height: 800px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .flex-col-center {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .social-icon {
        width: 25px;
        height: 25px;
    }

    a:focus {
        outline: none;
    }

    a:hover {
        cursor: pointer;
    }

    .app-store-icon {
        width: 30px;
        height: 30px;
    }

    .social-links {
        display: flex;
        width: 90px;
        justify-content: space-around;
        margin-top: 5px;
    }

</style>
<body>
    <div class="main" style="padding: 50px;">
        <div class="flex-col-center">
            <div><img style="width: 60px; height: 60px;" src="https://github.com/mattgoespro/public-resources/blob/master/images/SmellSense/Logo.png?raw=true"></img></div>
            <div style="font-size: 54px; line-height: 1;">Smell<span style="color: var(--blue);">Sense</span></div>
            <div style="font-size: 28px;">The Smell Retraining Tool</div>
        </div>
        <div style="margin-top: 10px; display: flex; flex-direction: column;">
            <div>Download</div>
            <div style="display: flex; justify-content: space-between;">
                <div style="display: flex; flex-direction: column;">
                    <div>Play</div>
                    <a href="https://play.google.com/store/apps/details?id=za.co.smellsense&hl=en_US&gl=US" style="vertical-align: middle;">
                        <img class="app-store-icon" src="https://github.com/mattgoespro/public-resources/blob/master/images/logos/google-play.png?raw=true">
                    </a>
                </div>
                <div style="display: flex; flex-direction: column;">
                    <div>iOS</div>
                    <a href="https://twitter.com/smellsense" style="vertical-align: middle;">
                        <img class="app-store-icon" src="https://github.com/mattgoespro/public-resources/blob/master/images/logos/ios-app-store.png?raw=true">
                    </a>
                </div>
            </div>
        </div>
        <div style="font-size: 12px; text-align: center;">Visit our social pages for updates.</div>
        <div class="social-links">
            <a href="https://facebook.com/pages/category/Product-Service/SmellSense-345235540113222/">
                <img class="social-icon" src="https://github.com/mattgoespro/public-resources/blob/master/images/logos/facebook.png?raw=true">
            </a>
            <a href="https://twitter.com/smellsense">
                <img class="social-icon" src="https://github.com/mattgoespro/public-resources/blob/master/images/logos/twitter.png?raw=true">
            </a>
        </div>
    </div>
</body>
</html>
