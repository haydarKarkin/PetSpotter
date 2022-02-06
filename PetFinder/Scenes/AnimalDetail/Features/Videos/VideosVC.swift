//
//  VideosVC.swift
//  PetFinder
//
//  Created by hkarkin on 7.02.2022.
//

import UIKit

class VideosVC: ViewController<VideosVM> {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var videos: [Video] = [Video]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        
        title = "Videos"
        
        // setup tableviewe
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Configs.UI.estimatedRowHeight
        tableView.registerCellNib(VideoCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = VideosVM.Input()
        
        viewModel.transform(input: input){ [weak self] (output) in
            guard let self = self else { return }
            self.videos = output.videos
        }
    }
}

// MARK: - Storyboarded
extension VideosVC: Storyboarded {
    static var storyboardName = StoryboardName.animalDetail
}

// MARK: - UITableViewDataSource
extension VideosVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: videos[indexPath.row], delegate: self)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension VideosVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UITableViewDelegate
extension VideosVC: VideoCellDelegate {
    
    func videoCell(_ cell: VideoCell, didCalculateHeight height: CGFloat) {
        DispatchQueue.main.async {
            self.tableView.rowHeight = height
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}
