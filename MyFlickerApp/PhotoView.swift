import UIKit
import SDWebImage



class PhotoView: UITableViewCell  {
    
    private static let nibName = "PhotoView"
    
    @IBOutlet var photoLbl: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    
    var url : String?
    var photoTitle: String?
    var photoDescription: String?

    class func registerForTableView(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    class func dequeueForTableView(tableView: UITableView, indexPath: NSIndexPath) -> PhotoView {
        return tableView.dequeueReusableCellWithIdentifier(nibName, forIndexPath: indexPath) as! PhotoView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {}
    
    private func initialize() {
        initializeContactPhoto()
    }
    
    func setRow(url : String, title : String, description : String){
        self.url = url
        self.photoTitle = title
        self.photoDescription = description
        fillData()
    }
    
    private func initializeContactPhoto() {
        photoLbl.superview!.layer.cornerRadius = photoLbl.superview!.frame.height/2
        photoLbl.superview!.layer.masksToBounds = true
        photoLbl.layer.cornerRadius = photoLbl.frame.height/2
        photoLbl.layer.masksToBounds = true
    }
    
    private func fillData() {
        showPhoto()
        setText()
    }

    private func showPhoto() {
        photoLbl.image = UIImage(named: "slack")

                photoLbl.sd_setImageWithURL(NSURL(string: url!), placeholderImage: UIImage(named: "ic_anonymUser"), completed: { (image:UIImage!, error: NSError!, type: SDImageCacheType, url: NSURL!) in
                    if image == nil {
                        self.photoLbl.image = UIImage(named: "slack")
                    }
                })
    }
    
    private func setText(){
        nameLbl.text = photoTitle
        descriptionLbl.text = photoDescription != nil ? photoDescription : "No description for this photo!"
    }

}
