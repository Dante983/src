import './module/custom-blog';

Shopware.Module.register('custom-blog', {
    type: 'plugin',
    name: 'custom-blog',
    title: 'Custom Blog Plugin',
    description: 'A custom blog plugin for Shopware 6',

    routes: {
        list: {
            component: 'custom-blog-list',
            path: 'list'
        },
        create: {
            component: 'custom-blog-create',
            path: 'create'
        },
        edit: {
            component: 'custom-blog-edit',
            path: 'edit/:id',
            meta: {
                parentPath: 'custom-blog-list'
            }
        },
    },

    navigation: [{
        id: 'custom-blog-list',
        label: 'Blog Posts',
        path: 'custom-blog.list',
        parent: 'sw-catalogue',
        position: 100
    }]
});
