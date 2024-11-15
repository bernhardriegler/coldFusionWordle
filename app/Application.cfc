component {
    this.name = "WordleApp";
    this.clientManagement = true;
    this.setClientCookies = true;
    this.clientStorage = "cookie"; // You can also use "registry" or "datasource" if configured

    function onApplicationStart() {
        application.words = ["apple", "grape", "peach", "berry", "melon"];
    }

    function onRequestStart(requestName) {
        if (!structKeyExists(client, "targetWord")) {
            client.targetWord = application.words[randRange(1, arrayLen(application.words))];
            client.attempts = 0;
            client.maxAttempts = 6;
        }
    }
}