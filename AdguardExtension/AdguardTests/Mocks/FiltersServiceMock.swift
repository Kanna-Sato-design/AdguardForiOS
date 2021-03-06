/**
   This file is part of Adguard for iOS (https://github.com/AdguardTeam/AdguardForiOS).
   Copyright © Adguard Software Limited. All rights reserved.

   Adguard for iOS is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Adguard for iOS is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Adguard for iOS.  If not, see <http://www.gnu.org/licenses/>.
*/

import Foundation

class FiltersServiceMock: FiltersServiceProtocol {
    var updateNotification: Notification.Name = Notification.Name("updateNotification")
    
    var groups: [Group] = []
    
    var activeFiltersCount: Int {
        return 0
    }
    
    func setGroup(_ groupId: Int, enabled: Bool) {
    }
    
    func setFilter(_ filter: Filter, enabled: Bool) {
        let filter = groups.flatMap { $0.filters }
            .first { $0.filterId == filter.filterId }
        filter?.enabled = enabled
    }
    
    func disableAllFilters() {
        for group in groups {
            for filter in group.filters {
                filter.enabled = false
            }
        }
    }
    
    func addCustomFilter(_ filter: AASCustomFilterParserResult) {
        var group = groups.first { $0.groupId == FilterGroupId.custom }
        if group == nil {
            group = Group(FilterGroupId.custom)
            groups.append(group!)
        }
        
        let filterObj = Filter(filterId: 0, groupId: FilterGroupId.custom)
        filterObj.name = filter.meta.name
        filterObj.enabled = true
        group!.filters.append(filterObj)
    }
    
    func deleteCustomFilter(_ filter: Filter) {
    }
    
    func load(refresh: Bool, _ completion: @escaping () -> Void) {
    }
    
    func reset() {
    }
    
    func updateGroups() {
    }
    
    func getGroup(_ groupId: Int) -> Group? {
        return nil
    }
    
    func renameCustomFilter(_ filterId: Int, _ newName: String) {
    }
    
}
