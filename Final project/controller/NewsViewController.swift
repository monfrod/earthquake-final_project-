//
//  ViewController.swift
//  Final project
//
//  Created by yunus on 14.12.2024.
//

import UIKit
import SDWebImage
import SafariServices


class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsData: NewsData?
    let newsManager = AFManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .background).async {
            self.newsManager.fetchNews { result in
                DispatchQueue.main.async {
                    self.newsData = result
                    self.tableView.reloadData()
                }
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        if let news = newsData?.articles {
            cell.titleLabel.text = news[indexPath.row].title
            let imageURL = URL(string: news[indexPath.row].urlToImage ?? "")
            cell.newsImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholderImage"))
            return cell
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = newsData?.articles[indexPath.row].url {
            let URL = URL(string: url)!
            let safariVC = SFSafariViewController(url: URL)
            present(safariVC, animated: true)
        }
    }
    
    
}

