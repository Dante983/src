<?php

namespace Custom\BlogPlugin\Controllers;

use Shopware\Core\Framework\Routing\Annotation\RouteScope;
use Shopware\Core\Framework\Routing\Annotation\Route;
use Shopware\Core\Framework\Context;
use Shopware\Core\Framework\DataAbstractionLayer\EntityRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Criteria;

/**
 * @RouteScope(scopes={"administration"})
 * @Route("/admin/api/v{version}/custom-blog", name="admin.custom-blog.")
 */
class NikolaCustomController extends AbstractController
{
    private $customBlogRepository;

    public function __construct(EntityRepository $customBlogRepository)
    {
        $this->customBlogRepository = $customBlogRepository;
    }

    /**
     * @Route("/list", name="list", methods={"GET"})
     */
    public function index(Request $request, Context $context): Response
    {
        // Fetch blog posts from the custom repository
        $criteria = new Criteria();
        $criteria->addAssociation('Nikola'); // Replace with the actual association name

        $blogPosts = $this->customBlogRepository->search($criteria, $context)->getEntities();

        // Render your Twig template with the fetched data
        return $this->render('@CustomBlogPlugin/admin/blog/index.html.twig', [
            'blogPosts' => $blogPosts,
        ]);
    }


    /**
     * @Route("/create", name="create", methods={"POST"})
     */
    public function createBlogPost(Request $request, Context $context): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $newBlogPost = [
            'title' => $data['title'],
            'content' => $data['content'],
            // Add other fields as needed
        ];

        $this->customBlogRepository->create([$newBlogPost], $context);

        return new JsonResponse(['message' => 'Blog post created successfully']);
    }

    // Add other actions like update and delete as needed
}
