inject = ->
	return if MathJax?

	config = document.createElement 'script'
	config.setAttribute 'type', 'text/x-mathjax-config'
	config.innerHTML = """
    MathJax.Hub.Config({
                        jax: ["input/TeX","input/MathML","input/AsciiMath","output/CommonHTML"],
      tex2jax: {inlineMath: [['$','$'], ['\\\\(','\\\\)']]}
    });

    // Renders math images using MathJax instead
    // which makes text selectable
    MathJax.Extension.myImg2jax = {
      version: "1.0",

      PreProcess: function (element) {
        var images = element.getElementsByTagName("img");
        for (var i = images.length - 1; i >= 0; i--) {
        var img = images[i];
        if (img.className === "mwe-math-fallback-image-inline") {
            var script = document.createElement("script");
            script.type = "math/tex";
            MathJax.HTML.setScript(script, img.alt);
            img.parentNode.replaceChild(script, img);
          }
        }
      }
    };

    MathJax.Hub.Register.PreProcessor(["PreProcess", MathJax.Extension.myImg2jax]);
  """

	cdn = document.createElement 'script'
	cdn.setAttribute 'type', 'text/javascript'
	cdn.setAttribute 'src', '//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML'

	document.head.appendChild config
	document.head.appendChild cdn

inject()
