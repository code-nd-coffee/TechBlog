<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="com.tech.blog.dao.LikeDao" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page import="java.util.List" %>
<%@page import="com.tech.blog.entities.Post" %>
<%@page import="com.tech.blog.entities.User" %>

<div class="row">
<%
    User user = (User)session.getAttribute("currentUser");
    Thread.sleep(500);
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    
    int cid = Integer.parseInt(request.getParameter("cid"));
    List<Post> list = null;
    if(cid == 0){
        list = d.getAllLists();
    } else{
        list = d.getAllPostByCatId(cid);
    }
    if(list.size() == 0){
        out.println("<h3 class= 'display-3 text-center'>No Post In This Category</h3>");
        return;
    }
    for(Post p : list){
    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="" alt="Card image cap">
            <div class="card-body">
                <b><%= p.getTitle() %></b>
                <p><%= p.getContent() %></p>
                <div class="card-footer primary-background text-center">
                    <% LikeDao dao = new LikeDao(ConnectionProvider.getConnection());%>
                    <a href="" onclick="doLike(<%= p.getPostId()%>,<%= user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i>&nbsp;<span class = "like-counter"><%= dao.countLikeOnPost(p.getPostId()) %></span></a>
                    <a href="showBlogPost.jsp?postId=<%= p.getPostId() %>" class="btn btn-outline-light btn-sm">Read More</a>
                    <a href="" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i>&nbsp;<span>5</span></a>
                </div>
            </div>
            
        </div>
    </div>
    
    <%
    }
%>
</div>