<template>
    <div>
      <h1>{{ $t('custom-blog-plugin.general.title') }}</h1>
      <table class="sw-data-grid">
        <thead>
          <tr>
            <th>{{ $t('custom-blog-plugin.list.title') }}</th>
            <th>{{ $t('custom-blog-plugin.list.publishDate') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="post in posts" :key="post.id">
            <td>{{ post.title }}</td>
            <td>{{ formatDate(post.publishDate) }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  export default {
    name: 'CustomBlogList',
    props: {
      posts: {
        type: Array,
        required: true,
      },
    },
    methods: {
      formatDate(date) {
        return new Date(date).toLocaleDateString();
      },
    },
  };
  </script>
  
  <style>
  /* Your CSS styles for the component */
  </style>
  