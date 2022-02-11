//
//  OrganizationDetailVC+TableAdapter.swift
//  PetFinder
//
//  Created by hkarkin on 6.02.2022.
//

import UIKit

protocol OrganizationDetailVCTableAdapterDelegate: AnyObject {
    func animalsTapped(id: String)
    func organizationDetailTapped(id: String)
    func videosTapped(videos: [Video])
    func imageDownloadFinish(with error: Error?)
}

protocol OrganizationDetailVCTableAdapterType: AnyObject {
    func reload()
}

// MARK: - OrganizationDetailVC.TableAdapter
extension OrganizationDetailVC {
    
    final class TableAdapter: NSObject, OrganizationDetailVCTableAdapterType {
        
        // MARK: Stored
        
        weak var tableView: UITableView?
        weak var delegate: OrganizationDetailVCTableAdapterDelegate?
        let organization: Organization
        lazy var dataSource = DetailDataSource(organization: organization, delegate: self)
        
        init(tableView: UITableView?,
             delegate: OrganizationDetailVCTableAdapterDelegate?,
             organization: Organization) {
            self.tableView = tableView
            self.delegate = delegate
            self.organization = organization
            super.init()
            configureView()
        }
        
        func configureView() {
            guard let tableView = tableView else {
                return
            }
            tableView.dataSource = dataSource
            tableView.delegate = self
            
            tableView.registerCellNib(TextCell.self)
            tableView.registerCellNib(ImageCell.self)
            tableView.registerCellNib(ButtonCell.self)
            tableView.registerHeaderFooterViewNib(HeaderView.self)
            
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 300
            tableView.separatorStyle = .none
            
        }
        
        func reload() {
            tableView?.reloadData()
        }
    }
}

extension OrganizationDetailVC.TableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: HeaderView = tableView.dequeueReusableHeaderFooterView()
        view.configure(title: dataSource.titles[section])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension OrganizationDetailVC.TableAdapter: DetailDataSourceDelegate {
    func animalsTapped(id: String) {
        delegate?.animalsTapped(id: id)
    }
    
    func organizationDetailTapped(id: String) {
        delegate?.organizationDetailTapped(id: id)
    }
    
    func videosTapped(videos: [Video]) {
        delegate?.videosTapped(videos: videos)
    }
    
    func imageDownloadFinish(with error: Error?) {
        tableView?.beginUpdates()
        tableView?.endUpdates()
        delegate?.imageDownloadFinish(with: error)
    }
}
