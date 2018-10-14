<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PagesController extends Controller
{
    public function index(){
        $title="Hello on my website!!";
        return view('pages.index',compact('title'));
    }
    public function about(){
        $title="All about you ABOUT!";
        return view('pages.about')->with('title',$title);
    }
    public function services(){
        // $title="This is our services!!";
        $data = array(
            'title' => 'Services',
            'services' => ['Web Design','Programming','SEO']
        );
        return view('pages.services')->with($data);
    }
}
