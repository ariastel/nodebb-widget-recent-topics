<div class="aa_recent-replies">
	<ul id="aa_recent_topics" data-numtopics="{numTopics}" data-cid="{cid}">
		<!-- IMPORT partials/aa_recenttopics-item.tpl -->
	</ul>
	<a href="{relative_path}/recent" class="aa_recent_topics">[[recent-topics:more]]>></a>
</div>

<script>
	'use strict';
	/* globals app, socket*/
	(function () {
		function onLoad() {

			var replies = $('#aa_recent_topics');
			var numTopics = parseInt(replies.attr('data-numtopics'), 10) || 4;

			var aa_recentTopicsWidget = app.widgets.aa_recentTopics;
			if (!aa_recentTopicsWidget) {
				aa_recentTopicsWidget = {};

				aa_recentTopicsWidget.onNewTopic = function (topic) {

					var recentTopics = $('#aa_recent_topics');
					if (!recentTopics.length) {
						return;
					}

					app.parseAndTranslate('partials/aa_recenttopics-item', {
						relative_path: config.relative_path,
						topics: [topic]
					}, function (html) {
						processHtml(html);
						html.hide()
							.prependTo(recentTopics)
							.fadeIn();
						app.createUserTooltips();
						if (recentTopics.children().length > numTopics) {
							recentTopics.children().last().remove();
						}
					});
				};

				app.widgets.aa_recentTopics = aa_recentTopicsWidget;
				socket.on('event:new_topic', app.widgets.aa_recentTopics.onNewTopic);
			}

			function processHtml(html) {
				if ($.timeago) {
					html.find('.timeago').timeago();
				}
			}
		}

		if (window.jQuery) {
			onLoad();
		} else {
			window.addEventListener('DOMContentLoaded', onLoad);
		}
	})();
</script>