import UIKit

/* enhanced data source protocol to include fetching an item */
protocol TableViewDataSource:UITableViewDataSource {
    func item(at indexPath:IndexPath) -> ItemViewModel?
}

class ListDataSource: NSObject, TableViewDataSource {
    
    let viewModels:[ItemViewModel]
    
    init(viewModels:[ItemViewModel]) {
        self.viewModels = viewModels
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let item = viewModels[indexPath.row]
        cell.configure(viewModel: item)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func item(at indexPath: IndexPath) -> ItemViewModel? {
        if indexPath.row >= viewModels.count { return nil }
        return viewModels[indexPath.row]
    }
}
