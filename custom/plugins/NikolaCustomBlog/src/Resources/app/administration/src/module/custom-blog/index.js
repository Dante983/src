import template from './components/list.html.twig';
import createTemplate from './components/create.html.twig';

Shopware.Component.register('create-blog-post', {
    createTemplate,

    data() {
        return {
            newBlogPost: {
                title: '',
                content: '',
            },
        };
    },

    methods: {
        onCreateBlogPost() {
            // Send a POST request to create a new blog post
            const newPostData = {
                title: this.newBlogPost.title,
                content: this.newBlogPost.content,
            };

            const apiUrl = '/api/v1/custom-blog/blog-post';

            axios.post(apiUrl, {
                title: this.newBlogPost.title,
                content: this.newBlogPost.content,
            })
            .then(response => {
                console.log('Blog post created successfully:', response.data);
            })
            .catch(error => {
                console.error('Error creating blog post:', error);
            });

            Shopware.Service('repositoryFactory').create('custom_blog_post')
                .save(newPostData)
                .then(response => {
                    console.log('Blog post created successfully:', response);
                })
                .catch(error => {
                    console.error('Error creating blog post:', error);
                });
        },
    },
});


Shopware.Component.register('custom-blog', {
    template,

    metaInfo() {
        return {
            title: this.$createTitle()
        };
    },
});

Shopware.Module.register('custom-blog', {
    navigation: [{
        id: 'custom.blog.index',
        label: 'Blog Plugin',
        color: '#ff3d58',
        path: 'custom.blog.index',
        icon: 'default-shopping-paper-bag-product',
        parent: 'sw-catalogue',
        position: 100
    }],
    routes: {
        index: {
            component: 'custom-blog',
            path: 'index' // This should match your controller route
        },
        create: {
            component: 'create-blog',
            path: 'create'
        },
    },
});
