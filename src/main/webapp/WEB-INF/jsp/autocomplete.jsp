<html><head title="osu">
    <style>
        html, body { width: 100%; height: 100%;}
        body { background: radial-gradient(ellipse at center, rgba(194,234,219,1) 0%,rgba(227,215,242,1) 74%,rgba(227,215,242,1) 74%); background-size: 300%; padding: 3em; color: #333; font-family: 'Source Sans Pro'; font-size: 20px; font-weight: 300; }

        #searchform { display: block; margin: 0 auto; width: 100%; max-width: 500px; transform: translateY(10%); }

        span { font-size: 1.5em; }
        #search-bar { display: block; margin: .25em 0 0; width: 100%; padding: .25em .5em; font-size: 1.2em; }

        .output {
            list-style: none;
            width: 100%;
            min-height: 0px;
            border-top: 0 !important;
            color: #767676;
            font-size: .75em;
            transition: min-height 0.2s;
            position: absolute;
            z-index: 5;
        }

        .output, #search-bar {
            background: #fff;
            border: 1px solid #767676;
        }

        .prediction-item {
            padding: .5em .75em;
            transition: color 0.2s, background 0.2s;
        }

        .output:hover .focus {
            background: #fff;
            color: #767676;
        }

        .prediction-item:hover, .focus,
        .output:hover .focus:hover {
            background: #ddd;
            color: #333;
        }

        .prediction-item:hover {
            cursor: pointer;
        }

        .prediction-item strong { color: #333; }
        .prediction-item:hover strong { color: #000; }

        p { margin-top: 1em; }
        h1 { color: #439973; padding-bottom: 5px; border-bottom: 2px dotted #439973; font-family: 'Patua One'; }

        #submit {
            display: block;
            margin: .5em 0 2.5em;
            padding: .25em .5em;
            font-size: 1.2em;
            color: #439973;
            border: 1px solid #439973;
            background: 0;
            transition: color 0.2s, background 0.2s;
        }

        #submit:hover {
            color: #fff;
            background: #439973;
        }

        /** custom normalize.css */
        *,*:before,*:after{-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;margin:0;padding:0;}article,aside,details,figcaption,figure,footer,header,hgroup,main,nav,section,summary{display:block}audio,canvas,video{display:inline-block}audio:not([controls]){display:none;height:0}[hidden],template{display:none}html{font-family:sans-serif;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}a{background:0 0}a:focus{outline:thin dotted}a:active,a:hover{outline:0}h1{font-size:2em;margin:.67em 0}abbr[title]{border-bottom:1px dotted}b,strong{font-weight:700}dfn{font-style:italic}hr{height:0}mark{background:#ff0;color:#000}code,kbd,pre,samp{font-family:monospace,serif;font-size:1em}pre{white-space:pre-wrap}q{quotes:"\201C" "\201D" "\2018" "\2019"}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sup{top:-.5em}sub{bottom:-.25em}img{border:0}svg:not(:root){overflow:hidden}figure{margin:0}fieldset{border:1px solid silver;margin:0 2px;padding:.35em .625em .75em}legend{border:0;padding:0}button,input,select,textarea{font-family:inherit;font-size:100%;margin:0}button,input{line-height:normal}button,select{text-transform:none}button,html input[type=button],input[type=reset],input[type=submit]{-webkit-appearance:button;cursor:pointer}button[disabled],html input[disabled]{cursor:default}input[type=checkbox],input[type=radio]{padding:0}input[type=search]{-webkit-appearance:textfield;}input[type=search]::-webkit-search-cancel-button,input[type=search]::-webkit-search-decoration{-webkit-appearance:none}button::-moz-focus-inner,input::-moz-focus-inner{border:0;padding:0}textarea{overflow:auto;vertical-align:top}table{border-collapse:collapse;border-spacing:0}
    </style>
    <script>
        $(document).ready(function(){

            var $terms = [
                    'search',
                    'test',
                    'css',
                    'apple',
                    'bear',
                    'cat',
                    'crabapple',
                    'creep',
                    'czar',
                    'danger',
                    'dominant',
                    'doppler',
                    'everclear',
                    'evangelism',
                    'frodo'
                ].sort(),
                $return = [];

            function strInArray(str, strArray) {
                for (var j=0; j<strArray.length; j++) {
                    if (strArray[j].match(str) && $return.length < 5) {
                        var $h = strArray[j].replace(str, '<strong>'+str+'</strong>');
                        $return.push('<li class="prediction-item"><span class="prediction-text">' + $h + '</span></li>');
                    }
                }
            }

            function nextItem(kp) {
                if ( $('.focus').length > 0 ) {
                    var $next = $('.focus').next(),
                        $prev = $('.focus').prev();
                }

                if ( kp == 38 ) { // Up

                    if ( $('.focus').is(':first-child') ) {
                        $prev = $('.prediction-item:last-child');
                    }

                    $('.prediction-item').removeClass('focus');
                    $prev.addClass('focus');

                } else if ( kp == 40 ) { // Down

                    if ( $('.focus').is(':last-child') ) {
                        $next = $('.prediction-item:first-child');
                    }

                    $('.prediction-item').removeClass('focus');
                    $next.addClass('focus');
                }
            }

            $(function(){
                $('#search-bar').keydown(function(e){
                    $key = e.keyCode;
                    if ( $key == 38 || $key == 40 ) {
                        nextItem($key);
                        return;
                    }

                    setTimeout(function() {
                        var $search = $('#search-bar').val();
                        $return = [];

                        strInArray($search, $terms);

                        if ( $search == '' || ! $('input').val ) {
                            $('.output').html('').slideUp();
                        } else {
                            $('.output').html($return).slideDown();
                        }

                        $('.prediction-item').on('click', function(){
                            $text = $(this).find('span').text();
                            $('.output').slideUp(function(){
                                $(this).html('');
                            });
                            $('#search-bar').val($text);
                        });

                        $('.prediction-item:first-child').addClass('focus');

                    }, 50);
                });
            });

            $('#search-bar').focus(function(){
                if ( $('.prediction-item').length > 0 ) {
                    $('.output').slideDown();
                }

                $('#searchform').submit(function(e){
                    e.preventDefault();
                    $text = $('.focus').find('span').text();
                    $('.output').slideUp();
                    $('#search-bar').val($text);
                    $('input').blur();
                });
            });

            $('#search-bar').blur(function(){
                if ( $('.prediction-item').length > 0 ) {
                    $('.output').slideUp();
                }
            });

        });
    </script>
</head>
<body>
<form id="searchform">
    <h1>Lazy Search Prediction</h1>
    <span>Search this site: </span>
    <input type="text" id="search-bar" autocomplete="off" />
    <ul class="output" style="display:none;">
    </ul>
    <button type="submit" id="submit">Search</button>
    <p>This is a pseudo predictive search I made for a client site. It suggests possible search terms from an array that could theoretically be filled from an outside source, but for my purposes is filled by, well, me.</p>
    <p>I'm slowly working to improve functionality, but it's got the basic stuff there.</p>
</form>

<link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400|Patua+One' rel='stylesheet' type='text/css'>
</body>
</html>