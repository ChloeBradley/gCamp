
<% if @task.errors.any? %>
 <div class= 'form-group'>
   <div class= 'col-sm-offset-2 col-sm-6'>
     <div class= 'alert alert-danger'>
       <div id="error_explanation">
        <h2><%= pluralize(@task.errors.count, "error") %> prohibited this post from being saved:</h2>
         <ul>
           <% @task.errors.full_messages.each do |msg| %>
           <li><%= msg %></li>
           <% end %>
         </ul>
       </div>
     </div>
  </div>
 </div>
<% end %>
