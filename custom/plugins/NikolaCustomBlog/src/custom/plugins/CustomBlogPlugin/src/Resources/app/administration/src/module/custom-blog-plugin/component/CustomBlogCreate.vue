<template>
    <div>
      <h2>Create New Blog Post</h2>
      <form @submit.prevent="createPost">
        <div>
          <label for="title">Title:</label>
          <input type="text" id="title" v-model="post.title" required />
        </div>
        <div>
          <label for="content">Content:</label>
          <textarea id="content" v-model="post.content" required></textarea>
        </div>
        <button type="submit">Create Post</button>
      </form>
    </div>
  </template>
  
  <script>
  export default {
    name: "CustomBlogCreate",
    data() {
      return {
        post: {
          title: "",
          content: "",
        },
      };
    },
    methods: {
      async createPost() {
        // Send a request to your API or service to create the new blog post
        try {
          const response = await this.$http.post(
            "/api/v1/_action/custom-blog", // Adjust the API endpoint
            this.post
          );
          // Handle success (e.g., show a success message)
          console.log("Blog post created:", response.data);
          // Redirect to the blog list page or take any other action
          this.$router.push({ name: "custom_blog.list" });
        } catch (error) {
          // Handle error (e.g., show an error message)
          console.error("Error creating blog post:", error);
        }
      },
    },
  };
  </script>
  
  <style>
  /* Add your component styles here */
  </style>
  