import UIKit

class QuizTableViewCell: UITableViewCell {
    
    private var quizName: String!
    private var quizDescription: String!
    private var quizAuthor: String!
    private var imageUrl: String!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setLayout()
    }
    
    func setQuizInfo(name: String, description: String, author: String, imageUrl: String) {
        quizName = name
        quizDescription = description
        quizAuthor = author
        self.imageUrl = imageUrl
    }
    
    private func setLayout() {
        self.backgroundColor = SystemDesign.quizCellColor
        self.layer.cornerRadius = 15
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageUrl)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        //imageView.layer.borderWidth = 1
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (maker) in
            maker.width.equalTo(130)
            maker.height.equalTo(130)
            maker.left.equalToSuperview().offset(10)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        let nameLabel = UILabel()
        nameLabel.text = quizName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(imageView.snp.right).offset(20)
            maker.top.equalToSuperview().offset(10)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = quizDescription
      
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 3
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(imageView.snp.right).offset(20)
            maker.top.equalTo(nameLabel.snp.bottom).offset(10)
            maker.right.equalToSuperview().offset(-20)
        }
        
        let authorLabel = UILabel()
        authorLabel.text = "By " + quizAuthor
        authorLabel.font = UIFont.systemFont(ofSize: 15.0)
        self.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(imageView.snp.right).offset(20)
            maker.top.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
    }

}
