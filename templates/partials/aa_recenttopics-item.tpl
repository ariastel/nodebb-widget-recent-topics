<!-- BEGIN topics -->
<li data-pid="{topics.tid}" class="aa_widget-topic">
	<div class="aa_widget-topic__header">
    <a href="<!-- IF topics.user.userslug -->{relative_path}/user/{topics.user.userslug}<!-- ELSE -->#<!-- ENDIF topics.user.userslug -->" class="aa_widget-topic__author">

      <!-- IF topics.user.picture -->
      <img title="{topics.user.username}" class="avatar not-responsive" src="{topics.user.picture}" />
      <!-- ELSE -->
      <div title="{topics.user.username}" class="avatar not-responsive" style="background-color: {topics.user.icon:bgColor};">{topics.user.icon:text}</div>
      <!-- ENDIF topics.user.picture -->
    </a>
    <span class="aa_widget-topic__time">
      <time class="timeago" datetime="{topics.timestampISO}" title="{topics.timestampISO}"></time>
    </span>
    <a href="{relative_path}/category/{topics.category.cid}" class="aa_widget-topic__category">
      {topics.category.name}
    </a>
  </div>
  <a href="{relative_path}/topic/{topics.tid}" class="aa_widget-topic__name">
		{topics.title}
	</a>
</li>
<!-- END topics -->