//
//  BreweryCardView.swift
//  OpenBreweryChallenge
//
//  Created by Thiago Nitschke Simões on 09/02/21.
//

import UIKit
import SwiftUI

class BreweryCardView: UITableViewCell, ViewCodeConfiguration {
    
    let colorImage = UIImage(color: .systemYellow, size: CGSize(width: 32, height: 32))
    let card = UIView(frame: .zero)
    let character = UILabel(frame: .zero)
    var rating: Int = 3 {
        didSet {
            ratingStars.attributedText = NSMutableAttributedString.generateStarsText(for: rating)
        }
    }
    var mainText = "Brewery name" {
        didSet {
            textLabel?.text = "   " + mainText
            character.text = mainText.first?.uppercased() ?? "B"
        }
    }
    private let ratingStars = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        contentView.addSubview(ratingStars)
        contentView.addSubview(card)
        contentView.sendSubviewToBack(card)
        
        imageView?.addSubview(character)
    }
    
    func setupConstraints() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0).isActive = true
        card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0).isActive = true
        
        guard let detailLabel = detailTextLabel,
              let circleImage = imageView
              else { return }
        ratingStars.translatesAutoresizingMaskIntoConstraints = false
        ratingStars.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor, constant: 50).isActive = true
        ratingStars.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16.0).isActive = true
        ratingStars.topAnchor.constraint(equalTo: detailLabel.topAnchor).isActive = true
        ratingStars.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor).isActive = true
        
        character.translatesAutoresizingMaskIntoConstraints = false
        character.centerXAnchor.constraint(equalTo: circleImage.centerXAnchor).isActive = true
        character.centerYAnchor.constraint(equalTo: circleImage.centerYAnchor).isActive = true
    }
    
    func configureViews() {
        contentView.backgroundColor = .systemGroupedBackground
        card.backgroundColor = .secondarySystemGroupedBackground
        card.layer.cornerRadius = 16.0
        card.clipsToBounds = true
        
        textLabel?.text = "   Brewery name"
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        detailTextLabel?.text = "   Rating"
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        ratingStars.attributedText = NSMutableAttributedString.generateStarsText(for: rating)
        ratingStars.font = UIFont.preferredFont(forTextStyle: .body)
        ratingStars.textAlignment = .right
        
        imageView?.image = colorImage
        imageView?.clipsToBounds = true
        imageView?.layer.cornerRadius = colorImage.size.width / 2
        
        character.text = "B"
        character.font = UIFont(descriptor: character.font.fontDescriptor.withSymbolicTraits(.traitBold)!, size: 22)
        character.textColor = .label
        character.alpha = 0.75
        
        selectionStyle = .gray
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.render()
    }
    
    override func didAddSubview(_ subview: UIView) {
        self.render()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = imageView!.frame.offsetBy(dx: 16.0, dy: 0.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

#if DEBUG
struct MyViewContainer: UIViewRepresentable {
    typealias UIViewType = BreweryCardView
    func makeUIView(context: Context) -> UIViewType {
        let view = UIViewType(frame: .zero)
        view.render()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct MyViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyViewContainer().colorScheme(.light)
            MyViewContainer().colorScheme(.dark)
        }.previewLayout(.fixed(width: 375, height: 92))
    }
}
#endif
