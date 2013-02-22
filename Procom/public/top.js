(function () {
	var $backToTopTxt = "", $backToTopEle = $('<div id="go-top"></div>').appendTo($("body")).text($backToTopTxt).attr("title", $backToTopTxt).click(function () {
		$("html, body").animate({ scrollTop: 0 }, 2000);
	}), $backToTopFun = function () {
		var st = $(document).scrollTop(), winh = $(window).height();
		(st > 0) ? $backToTopEle.fadeIn(1000) : $backToTopEle.fadeOut(500);
		if (!window.XMLHttpRequest) {
			$backToTopEle.css("top", st + winh - 166);
		}
	};
	$(window).bind("scroll", $backToTopFun);
	$(function () { $backToTopFun(); });
})();