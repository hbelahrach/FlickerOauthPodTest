import UIKit
import SDWebImage
import Alamofire


class MyImages: UIViewController {
    
    var urls :[String]?
    var photoTitles :[String]?
    var photoDescriptions :[String]?
    
    @IBOutlet var tableView: UITableView!
    
    init(PhotoTitles: [String], PhotoDescriptions :[String], urls :[String]) {
        super.init(nibName: nil, bundle: nil)
        self.photoTitles = PhotoTitles
        self.photoDescriptions = PhotoDescriptions
        self.urls = urls
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoView.registerForTableView(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController!.interactivePopGestureRecognizer!.enabled = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let photoView = PhotoView.dequeueForTableView(tableView, indexPath: indexPath)

            photoView.setRow(urls![indexPath.section], title: photoTitles![indexPath.section], description: photoDescriptions![indexPath.section])
        
            return photoView
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection secIndex: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }


    func tableView(tableView: UITableView, titleForHeaderInSection secIndex: Int) -> String? {
        return ""
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.urls!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection secIndex: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
}

