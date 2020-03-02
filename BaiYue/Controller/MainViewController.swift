//
//  MainViewController.swift
//  BaiYue
//
//  Created by qcj on 2017/12/10.
//  Copyright © 2017年 qcj. All rights reserved.
//

import UIKit
class MainViewController:UIViewController{
    let mColorValues=RGBColors()
    let mDimen=Dimen()
    let imageCount = 3
    var mMainScrollView: UIScrollView!
    var scrollView: UIScrollView!
    var pageView: UIPageControl!
    var timer: Timer?
    var line:UIView!
    var navigationBarH: CGFloat!//导航栏高度
    var statusBarH=UIApplication.shared.statusBarFrame.height//状态栏高度
    var mActivityIndicatorView:UIActivityIndicatorView!//跳转到答题卡的等待提示
    var mWrongSubjectsC:WrongSubjectViewController!
    var mCollectSubjectsC:CollectSubjectViewController!
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationBarH=self.navigationController?.navigationBar.frame.height
        setScrollView() //设置滑动视图
        setNavigationView()//设置顶部导航
        setupViews()//设置滑动广告图视图
        addTimer()//滑动视;图定时器
        setCatalogView()//设置目录视图
        setBookView()//设置书籍视图
    }
    
    //viewController的等待提示
    public func setProgressView(){
        mActivityIndicatorView.stopAnimating()
    }
    public func refreshWrongSubjectView(){
        mWrongSubjectsC.refreshView()
    }
    public func setWrongSubjectController(controller:WrongSubjectViewController){
        mWrongSubjectsC=controller
    }
    public func refreshCollectSubjectView(){
        mCollectSubjectsC.refreshView()
    }
    public func setCollectSubjectController(controller:CollectSubjectViewController){
        mCollectSubjectsC=controller
    }
    func setBookView(){
        let label = UILabel(frame:CGRect(x:0, y:line.frame.origin.y+5, width:mDimen.mScreenW, height:CGFloat(20)))
        label.text="推荐书籍"
        label.font = UIFont.systemFont(ofSize: CGFloat(15))
        label.textAlignment = .center;
        mMainScrollView.addSubview(label)
        let lines = UIView(frame: CGRect(x: CGFloat(0), y: line.frame.origin.y+25, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        lines.backgroundColor = mColorValues.LineColor
        mMainScrollView.addSubview(lines)
        let imageView=UIImageView(frame: CGRect(x:mDimen.mScreenW/12, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+40, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView.image=UIImage(named:"gonggong_book")
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(readJiChuBook))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        let imageView2=UIImageView(frame: CGRect(x:mDimen.mScreenW/12*2+mDimen.mBookViewW, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+40, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView2.image=UIImage(named:"daolu_book")
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(readDaoLuBook))
        imageView2.addGestureRecognizer(singleTapGesture2)
        imageView2.isUserInteractionEnabled = true
        imageView2.layer.shadowOpacity = 0.8
        imageView2.layer.shadowColor = UIColor.black.cgColor
        imageView2.layer.shadowOffset = CGSize(width: 2, height: 2)
        mMainScrollView.addSubview(imageView)
        mMainScrollView.addSubview(imageView2)
        
        let imageView3=UIImageView(frame: CGRect(x:mDimen.mScreenW/12, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+60+mDimen.mBookViewH, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView3.image=UIImage(named:"jiaotong_book")
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(readJiaoTongBook))
        imageView3.addGestureRecognizer(singleTapGesture3)
        imageView3.isUserInteractionEnabled = true
        
        let imageView4=UIImageView(frame: CGRect(x:mDimen.mScreenW/12*2+mDimen.mBookViewW, y:line.frame.origin.y+CGFloat(mDimen.mLineH)+60+mDimen.mBookViewH, width:mDimen.mBookViewW, height:mDimen.mBookViewH))
        imageView4.image=UIImage(named:"qiaoliang_book")
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(readQiaoLiangBook))
        imageView4.addGestureRecognizer(singleTapGesture4)
        imageView4.isUserInteractionEnabled = true
        
        imageView3.layer.shadowOpacity = 0.8
        imageView3.layer.shadowColor = UIColor.black.cgColor
        imageView3.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView4.layer.shadowOpacity = 0.8
        imageView4.layer.shadowColor = UIColor.black.cgColor
        imageView4.layer.shadowOffset = CGSize(width: 2, height: 2)
        mMainScrollView.addSubview(imageView3)
        mMainScrollView.addSubview(imageView4)
    }
    func setCatalogView(){
        let imageView = UIImageView(frame: CGRect(x: mDimen.mCatalogImageInterval, y: CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)), width: mDimen.mCatalogImageW, height: mDimen.mCatalogImageW))
        imageView.image = UIImage(named: "jichu")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor=mColorValues.MainCatalogImage1Color
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width/2//设置圆角半径(宽度的一半)，显示成圆形。
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(clickOne))
        imageView.addGestureRecognizer(singleTapGesture)
        imageView.isUserInteractionEnabled = true
        let label = UILabel(frame:CGRect(x:mDimen.mCatalogImageInterval, y:CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)+Int(mDimen.mCatalogImageW)+Int(mDimen.mCatalogTextHeightInterval)), width:mDimen.mCatalogImageW, height:CGFloat(mDimen.mCatalogTextH)))
        label.text = "公共基础"
        label.adjustsFontSizeToFitWidth=true
        let imageView2 = UIImageView(frame: CGRect(x: mDimen.mCatalogImageW*1+mDimen.mCatalogImageInterval*2, y: CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)), width: mDimen.mCatalogImageW, height: mDimen.mCatalogImageW))
        imageView2.image = UIImage(named: "daolu")
        imageView2.contentMode = .scaleAspectFill
        imageView2.backgroundColor=mColorValues.MainCatalogImage2Color
        imageView2.layer.masksToBounds = true
        imageView2.layer.cornerRadius = imageView.frame.width/2
        let singleTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(clickTwo))
        imageView2.addGestureRecognizer(singleTapGesture2)
        imageView2.isUserInteractionEnabled = true
        let label2 = UILabel(frame:CGRect(x:mDimen.mCatalogImageW*1+mDimen.mCatalogImageInterval*2, y:CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)+Int(mDimen.mCatalogImageW)+Int(mDimen.mCatalogTextHeightInterval)), width:mDimen.mCatalogImageW, height:CGFloat(mDimen.mCatalogTextH)))
        label2.text = "道路工程"
        label2.adjustsFontSizeToFitWidth=true
        let imageView3 = UIImageView(frame: CGRect(x: mDimen.mCatalogImageW*2+mDimen.mCatalogImageInterval*3, y: CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)), width: mDimen.mCatalogImageW, height: mDimen.mCatalogImageW))
        imageView3.image = UIImage(named: "jiaotong")
        imageView3.contentMode = .scaleAspectFill
        imageView3.backgroundColor=mColorValues.MainCatalogImage3Color
        imageView3.layer.masksToBounds = true
        imageView3.layer.cornerRadius = imageView.frame.width/2
        let singleTapGesture3 = UITapGestureRecognizer(target: self, action: #selector(clickThree))
        imageView3.addGestureRecognizer(singleTapGesture3)
        imageView3.isUserInteractionEnabled = true
        let label3 = UILabel(frame:CGRect(x:mDimen.mCatalogImageW*2+mDimen.mCatalogImageInterval*3, y:CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)+Int(mDimen.mCatalogImageW)+Int(mDimen.mCatalogTextHeightInterval)), width:mDimen.mCatalogImageW, height:CGFloat(mDimen.mCatalogTextH)))
        label3.text = "交通工程"
        label3.adjustsFontSizeToFitWidth=true
        let imageView4 = UIImageView(frame: CGRect(x: mDimen.mCatalogImageW*3+mDimen.mCatalogImageInterval*4, y: CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)), width: mDimen.mCatalogImageW, height: mDimen.mCatalogImageW))
        imageView4.image = UIImage(named: "qiaoliang")
        imageView4.contentMode = .scaleAspectFill
        imageView4.backgroundColor=mColorValues.MainCatalogImage4Color
        imageView4.layer.masksToBounds = true
        imageView4.layer.cornerRadius = imageView.frame.width/2
        let singleTapGesture4 = UITapGestureRecognizer(target: self, action: #selector(clickFour))
        imageView4.addGestureRecognizer(singleTapGesture4)
        imageView4.isUserInteractionEnabled = true
        let label4 = UILabel(frame:CGRect(x:mDimen.mCatalogImageW*3+mDimen.mCatalogImageInterval*4, y:CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)+Int(mDimen.mCatalogImageW)+Int(mDimen.mCatalogTextHeightInterval)), width:mDimen.mCatalogImageW, height:CGFloat(mDimen.mCatalogTextH)))
        label4.text = "桥梁隧道"
        label4.adjustsFontSizeToFitWidth=true
        line = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(Int(mDimen.mMainScrollViewH)+Int(mDimen.mCatalogImageHeightInterval)+Int(mDimen.mCatalogImageW)+Int(mDimen.mCatalogTextHeightInterval)+Int(mDimen.mCatalogTextH)), width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
        line.backgroundColor = mColorValues.LineColor
        
        mMainScrollView.addSubview(line)
        mMainScrollView.addSubview(imageView)
        mMainScrollView.addSubview(imageView2)
        mMainScrollView.addSubview(imageView3)
        mMainScrollView.addSubview(imageView4)
        mMainScrollView.addSubview(label)
        mMainScrollView.addSubview(label2)
        mMainScrollView.addSubview(label3)
        mMainScrollView.addSubview(label4)
    }
    func setScrollView(){
        mMainScrollView=UIScrollView(frame: CGRect(x: CGFloat(0), y: navigationBarH!+statusBarH, width:mDimen.mScreenW, height: mDimen.mScreenH))
        mMainScrollView.contentSize = CGSize(width: 0, height: mDimen.mScreenH*1.4)
        mMainScrollView.contentOffset = CGPoint(x: 0, y: 1)//设置偏移量，以固定的速度设置成新的偏移量
        mMainScrollView.isPagingEnabled = false//设置分页显示
        mMainScrollView.showsHorizontalScrollIndicator = false
        mMainScrollView.showsVerticalScrollIndicator = false
        mMainScrollView.backgroundColor=UIColor.white
        self.view.addSubview(mMainScrollView)
    }
    func setupViews() {
        automaticallyAdjustsScrollViewInsets = false
        mActivityIndicatorView=UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
        mActivityIndicatorView.frame = CGRect.init(x: 40, y: 100, width: 60, height: 60)
        mActivityIndicatorView.center=self.view.center
        mActivityIndicatorView.color=UIColor.white
        mActivityIndicatorView.backgroundColor = UIColor.gray
        mActivityIndicatorView.layer.masksToBounds = true
        mActivityIndicatorView.layer.cornerRadius = 6.0
        mActivityIndicatorView.layer.borderWidth = 1.0
        mActivityIndicatorView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(mActivityIndicatorView)
        do {
            scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width:mDimen.mScreenW, height: mDimen.mMainScrollViewH))
            scrollView.delegate = self as UIScrollViewDelegate
            let line = UIView(frame: CGRect(x: CGFloat(0), y: mDimen.mMainScrollViewH, width: mDimen.mScreenW, height: CGFloat(mDimen.mLineH)))
            line.backgroundColor = mColorValues.LineColor
            mMainScrollView.addSubview(line)
            mMainScrollView.addSubview(scrollView)
        }
        
        do {
            pageView = UIPageControl(frame: CGRect(x: 0, y: mDimen.mMainScrollViewH-30, width: mDimen.mScreenW, height: 30))
            mMainScrollView.addSubview(pageView)
            pageView.numberOfPages = imageCount
            pageView.currentPage = 0
            pageView.pageIndicatorTintColor = UIColor.white
            pageView.currentPageIndicatorTintColor = UIColor.blue
        }
        
        do {
            /// 只使用3个UIImageView，依次设置好最后一个，第一个，第二个图片，这里面使用取模运算。
            for index in 0..<3 {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * mDimen.mScreenW, y: 0, width: mDimen.mScreenW, height: mDimen.mMainScrollViewH))
                imageView.image = UIImage(named: "\((index + 3) % 4).png")
                scrollView.addSubview(imageView)
            }
        }
        
        do {
            scrollView.contentSize = CGSize(width: mDimen.mScreenW * 3, height: 0)
            scrollView.contentOffset = CGPoint(x: mDimen.mScreenW, y: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }
    
    /// 添加timer
    func addTimer() {
        /// 利用这种方式添加的timer 如果有列表滑动的话不会调用这个timer，因为当前runloop的mode更换了
        //        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] (timer) in
        //            self?.nextImage()
        //        })
        
        timer = Timer(timeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.nextImage()
        })
        
        guard let timer = timer else {
            return
        }
        RunLoop.current.add(timer, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    /// 下一个图片
    func nextImage() {
        if pageView.currentPage == imageCount - 1 {
            pageView.currentPage = 0
        } else {
            pageView.currentPage += 1
        }
        let contentOffset = CGPoint(x: mDimen.mScreenW * 2, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 上一个图片
    func preImage() {
        if pageView.currentPage == 0 {
            pageView.currentPage = imageCount - 1
        } else {
            pageView.currentPage -= 1
        }
        
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 重新加载图片，重新设置3个imageView
    func reloadImage() {
        let currentIndex = pageView.currentPage
        let nextIndex = (currentIndex + 1) % 4
        let preIndex = (currentIndex + 3) % 4
        
        (scrollView.subviews[0] as! UIImageView).image = UIImage(named: "\(preIndex).png")
        (scrollView.subviews[1] as! UIImageView).image = UIImage(named: "\(currentIndex).png")
        (scrollView.subviews[2] as! UIImageView).image = UIImage(named: "\(nextIndex).png")
    }
    private func setNavigationView(){
        
        self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor(red: CGFloat(mColorValues.RBGColorNavigationBg[0]/255), green: CGFloat(mColorValues.RBGColorNavigationBg[1]/255), blue: CGFloat(mColorValues.RBGColorNavigationBg[2]/255), alpha: 1)
        self.navigationItem.title="百跃试验检测考试"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
    }
}
extension MainViewController: UIScrollViewDelegate {
    
    /// 开始滑动的时候，停止timer，设置为niltimer才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    /// 当停止滚动的时候重新设置三个ImageView的内容，然后悄悄滴显示中间那个imageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: mDimen.mScreenW, y: 0), animated: false)
    }
    
    /// 停止拖拽，开始timer, 并且判断是显示上一个图片还是下一个图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        if scrollView.contentOffset.x < mDimen.mScreenW {
            preImage()
        } else {
            nextImage()
        }
    }
    @objc func readJiChuBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "jichu")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readDaoLuBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "daolu")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readJiaoTongBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "jiaotong")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func readQiaoLiangBook(){
        let bookDetailsViewC=BookDetailsViewController()
        bookDetailsViewC.setBookName(bookName: "qiaoliang")
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func clickOne(){
        mActivityIndicatorView.startAnimating()
        let bookDetailsViewC=TabSubjectsViewController()
        bookDetailsViewC.setBookName(bookName: "jichu")
        bookDetailsViewC.setController(controller: self)
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func clickTwo(){
        mActivityIndicatorView.startAnimating()
        let bookDetailsViewC=TabSubjectsViewController()
        bookDetailsViewC.setBookName(bookName: "daolu")
        bookDetailsViewC.setController(controller: self)
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func clickThree(){
        mActivityIndicatorView.startAnimating()
        let bookDetailsViewC=TabSubjectsViewController()
        bookDetailsViewC.setBookName(bookName: "jiaotong")
        bookDetailsViewC.setController(controller: self)
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    @objc func clickFour(){
        
        mActivityIndicatorView.startAnimating()
        let bookDetailsViewC=TabSubjectsViewController()
        bookDetailsViewC.setBookName(bookName: "qiaoliang")
        bookDetailsViewC.setController(controller: self)
        let bookDetailsViewNC=UINavigationController(rootViewController: bookDetailsViewC)
        self.present(bookDetailsViewNC, animated: true, completion: nil)
    }
    
}
