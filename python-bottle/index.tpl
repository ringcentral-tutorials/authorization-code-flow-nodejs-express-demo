<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script>

var config = {
    authUri: '{{ authorize_uri }}',
    redirectUri: '{{ redirect_uri }}',
}
config['authUri'] = config['authUri'].replace(/&amp;/g, '&');

var OAuthCode = function(config) {
    this.config = config;
    this.loginPopup  = function() {
        this.loginPopupUri(this.config['authUri'], this.config['redirectUri']);
    }
    this.loginPopupUri  = function(authUri, redirectUri) {
        var win         = window.open(authUri, 'windowname1', 'width=800, height=600'); 

        var pollTimer   = window.setInterval(function() { 
            try {
                console.log(win.document.URL);
                if (win.document.URL.indexOf(redirectUri) != -1) {
                    window.clearInterval(pollTimer);
                    //win.close();
                    //location.reload();
                }
            } catch(e) {
                console.log(e)
            }
        }, 100);
    }
}

var oauth = new OAuthCode(config);

		</script>
	</head>
	<body>
		<h1>RingCentral 3-Legged OAuth 2.0 Demo in Python</h1>

		<p><input type="button" onclick="oauth.loginPopup()" value="Login with RingCentral"></p>

        <p>After retrieving the token use the Python SDK's auth class's set_data method to load the access_token.</p>

        <p>Access Token</p>
        <pre style="background-color:#efefef;padding:1em;overflow-x:scroll">{{ token_json }}</pre>

	</body>
</html>