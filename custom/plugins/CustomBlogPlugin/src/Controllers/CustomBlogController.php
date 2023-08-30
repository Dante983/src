<?php

namespace Custom\BlogPlugin\Controllers;

use Doctrine\DBAL\Connection;
use Shopware\Core\Framework\DataAbstractionLayer\EntityRepository;
use Shopware\Core\Framework\Routing\Annotation\RouteScope;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Criteria;
use Shopware\Core\Framework\Context;
use Shopware\Core\Framework\Validation\DataBag\RequestDataBag;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Shopware\Core\Framework\Log\Package;

#[Package('administration')]
class CustomBlogController extends AbstractController
{

    /**
     * @Route("/admin/custom-blog/list", name="custom_blog.list", methods={"GET"})
     */
    public function listAction(Request $request, EntityRepository $blogPostRepository): Response
    {
        // Fetch your blog posts from the database or any other source
        $posts = $this->fetchBlogPosts($blogPostRepository);

        return $this->render('@CustomBlogPlugin/administration/index.html.twig', [
            'posts' => $posts,
        ]);
    }

    /**
     * @Route("/admin/custom-blog/create", name="custom_blog.create", methods={"GET"})
     */
    public function createPostAction(): Response
    {
        return $this->render('@CustomBlogPlugin/administration/custom_blog_plugin/create_post.html.twig');
    }

    /**
     * @Route("/admin/custom-blog/store", name="custom_blog.store", methods={"POST"})
     */
    public function storePostAction(Request $request, Context $context, ValidatorInterface $validator): JsonResponse
    {
        $data = new RequestDataBag(json_decode($request->getContent(), true));
    
        // Validate the incoming data
        $violations = $validator->validate($data->all());
        if (count($violations) > 0) {
            // Handle validation errors and return a response
        }
        
        // Proceed with storing the data
        $this->blogPostRepository->create([$data->all()], $context);

        return new JsonResponse(['success' => true]);
    }

    /**
     * @Route("/admin/custom-blog/{id}/delete", name="custom_blog.delete", methods={"POST"})
     */
    public function deletePostAction(string $id, Context $context): JsonResponse
    {
        $this->blogPostRepository->delete([['id' => $id]], $context);

        return new JsonResponse(['success' => true]);
    }

    private function fetchBlogPosts(EntityRepository $blogPostRepository)
    {
        $criteria = new Criteria();
        $context = Context::createDefaultContext();
        $blogPosts = $blogPostRepository->search($criteria, $context);

        return $blogPosts;
    }

    // Other methods for edit, update, and more if needed
}
