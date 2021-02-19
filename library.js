'use strict';

const nconf = require.main.require('nconf');
const topics = require.main.require('./src/topics');

let app;
const Widget = {};

Widget.init = async function (params) {
	app = params.app;
};

Widget.defineWidgets = async function (widgets) {
	return widgets.concat([
		{
			widget: 'aa_recenttopics',
			name: 'Ariastel: Recent Topics',
			description: 'Displays a Recent topics.',
			content: await app.renderAsync('admin/aa_recenttopics', {}),
		}
	]);
}

Widget.renderRecentTopicsWidget = async function (widget) {

	const numTopics = (widget.data.numTopics ?? 8) - 1;
	const cids = getCidsArray(widget);
	
	let key;
	if (cids.length) {
		if (cids.length === 1) {
			key = 'cid:' + cids[0] + ':tids';
		} else {
			key = cids.map(cid => 'cid:' + cid + ':tids');
		}
	} else {
		key = 'topics:recent';
	}

	const topicsData = await topics.getTopicsFromSet(key, widget.uid, 0, Math.max(0, numTopics));

	const data = {
		topics: topicsData.topics.filter(filterTopic),
		numTopics: numTopics,
		relative_path: nconf.get('relative_path'),
	};

	widget.html = await app.renderAsync('widgets/aa_recenttopics', data);
	return widget;
};

function getCidsArray(widget) {
	const cids = widget.data.cid || '';
	return cids.split(',').map(c => parseInt(c, 10)).filter(Boolean);
}

function filterTopic(topic) {
	return !topic.deleted;
}

module.exports = Widget;