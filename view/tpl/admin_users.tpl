<script>
	function confirm_delete(uname){
		return confirm( "{{$confirm_delete}}".format(uname));
	}
	function confirm_delete_multi(){
		return confirm("{{$confirm_delete_multi}}");
	}
	function selectall(cls){
		$("."+cls).attr('checked','checked');
		return false;
	}
</script>
<div class = "generic-content-wrapper-styled" id='adminpage'>
	<h1>{{$title}} - {{$page}}</h1>
	
	<form action="{{$baseurl}}/admin/users" method="post">
        <input type='hidden' name='form_security_token' value='{{$form_security_token}}'>
		
		<h3>{{$h_pending}}</h3>
		{{if $pending}}
			<table id='pending'>
				<thead>
				<tr>
					{{foreach $th_pending as $th}}<th>{{$th}}</th>{{/foreach}}
					<th></th>
					<th></th>
				</tr>
				</thead>
				<tbody>
			{{foreach $pending as $u}}
				<tr>
					<td class="created">{{$u.account_created}}</td>
					<td class="email">{{$u.account_email}}</td>
					<td class="checkbox"><input type="checkbox" class="pending_ckbx" id="id_pending_{{$u.hash}}" name="pending[]" value="{{$u.hash}}" /></td>
					<td class="tools">
						<a href="{{$baseurl}}/regmod/allow/{{$u.hash}}" title='{{$approve}}'><i class='icon-thumbs-up-alt admin-icons'></i></a>
						<a href="{{$baseurl}}/regmod/deny/{{$u.hash}}" title='{{$deny}}'><i class='icon-thumbs-down-alt admin-icons'></i></a>
					</td>
				</tr>
			{{/foreach}}
				</tbody>
			</table>
			<div class='selectall'><a href='#' onclick="return selectall('pending_ckbx');">{{$select_all}}</a></div>
			<div class="submit"><input type="submit" name="page_users_deny" value="{{$deny}}"/> <input type="submit" name="page_users_approve" value="{{$approve}}" /></div>			
		{{else}}
			<p>{{$no_pending}}</p>
		{{/if}}
	
	
		
	
		<h3>{{$h_users}}</h3>
		{{if $users}}
			<table id='users'>
				<thead>
				<tr>
					{{foreach $th_users as $th}}<th>{{$th}}</th>{{/foreach}}
					<th></th>
					<th></th>
				</tr>
				</thead>
				<tbody>
				{{foreach $users as $u}}
					<tr>
						<td class='account_id'>{{$u.account_id}}</td>
						<td class='email'>{{if $u.blocked}}
							<i>{{$u.account_email}}</i>
						{{else}}
							<strong>{{$u.account_email}}</strong>
						{{/if}}</td>
						<td class='channels'>{{$u.channels}}</td>
						<td class='register_date'>{{$u.account_created}}</td>
						<td class='login_date'>{{$u.account_lastlog}}</td>
						<td class='account_expires'>{{$u.account_expires}}</td>
						<td class='service_class'>{{$u.account_service_class}}</td>
						<td class="checkbox"><input type="checkbox" class="users_ckbx" id="id_user_{{$u.account_id}}" name="user[]" value="{{$u.account_id}}"/></td>
						<td class="tools">
							<a href="{{$baseurl}}/admin/users/block/{{$u.account_id}}?t={{$form_security_token}}" title='{{if ($u.blocked)}}{{$unblock}}{{else}}{{$block}}{{/if}}'><i class='icon-ban-circle admin-icons {{if ($u.blocked)}}dim{{/if}}'></i></a>
							<a href="{{$baseurl}}/admin/users/delete/{{$u.account_id}}?t={{$form_security_token}}" title='{{$delete}}' onclick="return confirm_delete('{{$u.name}}')"><i class='icon-trash admin-icons'></i></a>
						</td>
					</tr>
				{{/foreach}}
				</tbody>
			</table>
			<div class='selectall'><a href='#' onclick="return selectall('users_ckbx');">{{$select_all}}</a></div>
			<div class="submit"><input type="submit" name="page_users_block" value="{{$block}}/{{$unblock}}" /> <input type="submit" name="page_users_delete" value="{{$delete}}" onclick="return confirm_delete_multi()" /></div>						
		{{else}}
			NO USERS?!?
		{{/if}}
	</form>
</div>
