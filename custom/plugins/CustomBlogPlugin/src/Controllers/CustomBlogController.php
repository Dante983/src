<?php

namespace Custom\BlogPlugin\Controllers;

use Shopware\Core\Framework\DataAbstractionLayer\Search\Criteria;
use Shopware\Core\Framework\Routing\Annotation\RouteScope;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Shopware\Core\Framework\Context;
use Symfony\Component\HttpFoundation\JsonResponse;


/**
 * @RouteScope(scopes={"administration"})
 */
class CustomBlogController extends AbstractController
{

    /**
     * @Route("/admin/custom-blog", name="custom_blog.list", methods={"GET"})
     */
    public function index()
    {
        return $this->render('@CustomBlogPlugin/admin/list.twig');
    }

    /**
     * @Route("/admin/custom-blog/create", name="custom_blog.create", methods={"GET"})
     */
    public function createPostAction(Request $request): Response
    {
        

        return $this->render('@CustomBlogPlugin/administration/custom_blog_plugin/create_post.html.twig', [
            
        ]);
    } 

    /**
     * @Route("/admin/custom-blog/list", name="custom_blog.list", methods={"GET"})
     */
    public function listAction(Request $request): Response
    {
        // Fetch blog posts from the database
        $posts = $this->fetchBlogPosts();

        return $this->render('@CustomBlogPlugin/administration/list.html.twig', [
            'posts' => $posts, // Pass blog posts to the template
        ]);
    }

    private function fetchBlogPosts()
    {
        
        $criteria = new Criteria();
        

        // Fetch the blog posts 
        $context = Context::createDefaultContext();
        $blogPosts = $this->blogPostRepository->search($criteria, $context);

        return $blogPosts;
    }

   

    /**
     * @Route("/admin/custom-blog/{id}", name="custom_blog.edit", methods={"GET"})
     */
    public function edit(string $id)
    {
        return $this->render('@CustomBlogPlugin/admin/edit.twig', ['postId' => $id]);
    }

    // /**
    //  * @Route("/api/v{version}/_action/custom-blog/{id}", name="api.custom_blog.update", methods={"PATCH"})
    //  */
    // public function update(Request $request, string $id): JsonResponse
    // {
    //     
    // }

    // /**
    //  * @Route("/api/v{version}/_action/custom-blog/{id}", name="api.custom_blog.delete", methods={"DELETE"})
    //  */
    // public function delete(string $id, Context $context): JsonResponse
    // {
    //     
    // }


}
