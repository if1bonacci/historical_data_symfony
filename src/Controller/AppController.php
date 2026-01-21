<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Attribute\Route;

final class AppController extends AbstractController
{
    #[Route('/test', name: 'test_route')]
    public function index(): void
    {
        dump('Hello World!');die;
    }
}