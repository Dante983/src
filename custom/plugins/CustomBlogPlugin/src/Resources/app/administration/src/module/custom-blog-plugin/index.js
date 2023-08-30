import './component/CustomBlogList.vue';
import './component/CustomBlogCreate.vue';
// import './component/CustomBlogCreate.vue';
import deDE from './snippet/de-DE/de-DE.json';
import enGB from './snippet/en-GB/en_GB.json';

Shopware.Module.register('custom-blog-plugin', {
    type: 'plugin',
    name: 'Custom Blog Plugin',
    title: 'custom-blog-plugin.general.mainMenuItemGeneral',
    description: 'Manage custom blog posts',
    color: '#ff8800',
    icon: 'default-text',
    routes: {
        list: {
            component: 'custom-blog-list',
            path: 'list',
        },
        create: {
            component: 'custom-blog-create', // Use your new component
            path: 'create', // Update the path to your preference
        },
        // Other routes...
    },
    navigation: [
        {
            label: 'custom-blog-plugin.menu.main-catalogues',
            color: '#ff8800',
            icon: 'default-text',
            path: 'custom.blog.list',
            children: [
                {
                    label: 'custom-blog-plugin.menu.custom-blog',
                    path: 'custom-blog-plugin.list',
                    icon: 'default-text',
                    color: '#ff8800',
                    parent: 'custom.blog.list',
                },
                {
                    label: 'custom-blog-plugin.menu.create-blog', // Add a new menu item
                    path: 'custom-blog-plugin.create', // Use the new route
                    icon: 'default-text',
                    color: '#ff8800',
                    parent: 'custom.blog.list',
                },
            ],
        },
    ],
    components: {
        'custom-blog-list': {
            component: 'custom-blog-list' // Register your component here
        },
        'custom-blog-edit': {
            component: 'custom-blog-edit' // Register your component here
        },
        'custom-blog-create': {
            component: 'custom-blog-create' // Register your component here
        }
    },
    snippets: {
        'de-DE': deDE,
        'en-GB': enGB
    },
});
