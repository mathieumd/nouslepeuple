{************************************
******* User Follow Template ********
 This template controls the user friend/follower pages
*************************************}
{include file=$the_template"/user_navigation.tpl"}

<!-- user_follow.tpl -->
{***********************************************************************************}
{if $user_view eq 'removefriend'}
	<div class="alert">
		<button class="close" data-dismiss="alert">&times;</button>
		{#PLIGG_Visual_User_Profile_Friend_Removed#}
	</div>
{/if}
{***********************************************************************************}
{if $user_view eq 'addfriend'}
	<div class="alert">
		<button class="close" data-dismiss="alert">&times;</button>
		{#PLIGG_Visual_User_Profile_Friend_Added#}
	</div>
{/if}
{***********************************************************************************}
{if $user_view eq 'removefriend' || $user_view eq 'addfriend'}
	<div id="profile_container" style="position: relative;">
		<div class="row-fluid">
			{checkActionsTpl location="tpl_pligg_profile_info_start"}
			{checkActionsTpl location="tpl_pligg_profile_info_middle"}
			<div id="stats" class="masonry span6" style="margin-left:10px">
				<table class="table table-bordered table-striped"">
					<thead class="table_title">
						<tr>
							<th colspan="2">{#PLIGG_Visual_User_Profile_User_Stats#}</th>
						</tr>
					</thead>
					<tbody>
						{if $user_karma > "0.00"}
							<tr>
								<td><strong>{#PLIGG_Visual_Rank#}:</strong></td>
								<td>{$user_rank}</td>
							</tr>
							<tr>
								<td><strong>{#PLIGG_Visual_User_Profile_KarmaPoints#}:</strong></td>
								<td>{$user_karma|number_format:"0"}</td>
							</tr>
						{/if}
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Joined#}:</strong></td>
							<td width="120px">
								{*	{$user_joined}	*}
								{php}
									$pligg_date = $this->_vars['user_joined'];
									echo date("F d, Y", strtotime($pligg_date));
								{/php}
							</td>	
						</tr>
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Total_Links#}:</strong></td>
							<td>{$user_total_links}</td>
						</tr>
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Published_Links#}:</strong></td>
							<td>{$user_published_links}</td>
						</tr>
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Total_Comments#}:</strong></td>
							<td>{$user_total_comments}</td>
						</tr>
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Total_Votes#}:</strong></td>
							<td>{$user_total_votes}</td>
						</tr>
						{*
						<tr>
							<td><strong>{#PLIGG_Visual_User_Profile_Published_Votes#}:</strong></td>
							<td>{$user_published_votes}</td>
						</tr>
						*}
					</tbody>
				</table>
			</div>
			{if $enable_group eq "true"}
				<div id="groups" class="masonry span6" style="margin-left:10px">
					<table class="table table-bordered table-striped"">
						<thead class="table_title">
							<tr>
								<th>Group Name</th>
								<th style="width:60px;text-align:center;">Members</th>
							</tr>
						<tbody>
							{if $group_display eq ''}
								<tr>
									<td colspan="2">
										{#Pligg_Profile_No_Membership#}
									</td>
								</tr>
							{else}
								{$group_display}
							{/if}
						</tbody>
					</table>
				</div>
			{/if}
			{if $Allow_Friends neq "0"}
				<div id="following" class="masonry span6" style="margin-left:10px">
					<table class="table table-bordered table-striped"">
						<thead class="table_title">
							<tr>
								<th>{#PLIGG_Visual_Login_Username#}</th>
								{checkActionsTpl location="tpl_pligg_profile_friend_th"}
								{if $user_login eq $user_logged_in}<th>{#PLIGG_Visual_User_Profile_Remove_Friend#}</th>{/if}
							</tr>
						</thead>
						<tbody>
							{if $following}
								{foreach from=$following item=myfriend}
									{php}
										$this->_vars['friend_avatar'] = get_avatar('small', $this->_vars['myfriend']['user_avatar_source'], $this->_vars['myfriend']['user_login'], $this->_vars['myfriend']['user_email']);
										$this->_vars['profileURL'] = getmyurl('user2', $this->_vars['myfriend']['user_login'], 'profile');
										$this->_vars['removeURL'] = getmyurl('user_add_remove', $this->_vars['myfriend']['user_login'], 'removefriend');
									{/php}
									<tr>
										<td>
											<a href="{$profileURL}"><img src="{$friend_avatar}" style="text-decoration:none;border:0;"/></a>
											<a href="{$profileURL}">{$myfriend.user_login}</a>
										</td>
										{checkActionsTpl location="tpl_pligg_profile_friend_td"}
										{if $user_login eq $user_logged_in}
											<td>
												<a class="btn btn-danger" href="{$removeURL}">Unfollow</a>
											</td>
										{/if}
									</tr>
								{/foreach}
							{else}
								<tr>
									<td colspan="3">
										{$user_username|capitalize} {#PLIGG_Visual_User_Profile_No_Friends#}
									</td>
								</tr>
							{/if}
						</tbody>
					</table>
				</div>
			{/if}
			{checkActionsTpl location="tpl_pligg_profile_info_end"}
			<div style="clear:both;"> </div>
			{checkActionsTpl location="tpl_pligg_profile_tab_insert"}
		</div>
	</div>
{/if}
{***********************************************************************************}
{if $user_view eq 'following'}
	<legend>{#PLIGG_Visual_User_Profile_People#} {$user_username|capitalize} {#PLIGG_Visual_User_Profile_Is_Following#}</legend>
	{if $following}
	  	<table class="table table-bordered table-condensed table-striped">
			<thead>
				<th>{#PLIGG_Visual_User_Profile_Username#}</th>
				{if check_for_enabled_module('simple_messaging',0.6) && $is_friend}<th>{#PLIGG_Visual_User_Profile_Message#}</th>{/if}
				<th>{#PLIGG_Visual_User_Profile_Remove_Friend#}</th>
			</thead>
			<tbody>
				{foreach from=$following item=myfriend}
					{php}
						$this->_vars['friend_avatar'] = get_avatar('small', $this->_vars['myfriend']['user_avatar_source'], $this->_vars['myfriend']['user_login'], $this->_vars['myfriend']['user_email']);
						$this->_vars['profileURL'] = getmyurl('user2', $this->_vars['myfriend']['user_login'], 'profile');
						$this->_vars['removeURL'] = getmyurl('user_add_remove', $this->_vars['myfriend']['user_login'], 'removefriend');
					{/php}
					<tr>
						<td><img src="{$friend_avatar}" align="absmiddle" /> <a href="{$profileURL}">{$myfriend.user_login}</a></td>
						{if check_for_enabled_module('simple_messaging',0.6) && $is_friend}<td align="center"><a href="{$my_pligg_base}/module.php?module=simple_messaging&view=compose&return={$templatelite.server.REQUEST_URI|urlencode}&to={$myfriend.user_login}"><i class="icon icon-envelope"></i></a></td>{/if}
						<td align="center"><a href="{$removeURL}" class="btn btn-danger">Unfollow</a></td>
					</tr>
				{/foreach}
			<tbody>
		</table>
	{else}
		<br /><br />
		<h3 style="text-align:center;">{$user_username|capitalize} {#PLIGG_Visual_User_Profile_No_Friends#}</h3>
	{/if}
{/if}
{***********************************************************************************}
{if $user_view eq 'followers'}
	<legend>{#PLIGG_Visual_User_Profile_Viewing_Friends_2a#} {$user_username|capitalize}</legend>
	{if $follower}
	  	<table class="table table-bordered table-condensed table-striped">
			<thead>
				<tr>
					<th>{#PLIGG_Visual_User_Profile_Username#}</th>
					{if check_for_enabled_module('simple_messaging',0.6) && $is_friend}
						<th>{#PLIGG_Visual_User_Profile_Message#}</th>
					{/if}
					<th>Add/Remove</th>
				</tr>
			</thead>
			<tbody>
				{foreach from=$follower item=myfriend}
					{php}
						$this->_vars['friend_avatar'] = get_avatar('small', $this->_vars['myfriend']['user_avatar_source'], $this->_vars['myfriend']['user_login'], $this->_vars['myfriend']['user_email']);
						$this->_vars['profileURL'] = getmyurl('user2', $this->_vars['myfriend']['user_login'], 'profile');
						$this->_vars['removeURL'] = getmyurl('user_add_remove', $this->_vars['myfriend']['user_login'], 'removefriend');
					{/php}

					<tr>
						<td><img src="{$friend_avatar}" align="absmiddle" /> <a href="{$profileURL}">{$myfriend.user_login}</a></td>
						{if check_for_enabled_module('simple_messaging',0.6) && $is_friend}<td><a href="{$my_pligg_base}/module.php?module=simple_messaging&view=compose&to={$myfriend.user_login}&return={$templatelite.server.REQUEST_URI|urlencode}"><span class="btn"><i class="icon icon-envelope"></i></span></a></td>{/if}
						{if $user_authenticated eq true}
							{*
							{if $is_friend gt 0}
								<td><a class="btn btn-danger" href="{$removeURL}">Unfollow</a></td>
							{/if}
							*}
								<td><a class="btn btn-success" href="{$user_url_add}">{#PLIGG_Visual_User_Profile_Add_Friend#}</a></td>
							
						{/if}
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
		<h4>{#PLIGG_Visual_User_Profile_No_Friends_2#} {$user_username|capitalize}</h4>
	{/if}
{/if}
{***********************************************************************************}
{if isset($user_page)}
	{$user_page}
{/if}
{if isset($user_pagination)}{checkActionsTpl location="tpl_pligg_pagination_start"}{$user_pagination}{checkActionsTpl location="tpl_pligg_pagination_end"}{/if}
{checkActionsTpl location="tpl_pligg_profile_end"}
<!--/user_center.tpl -->