package com.dao;

import java.util.List;

import com.model.Location;
import com.model.Zone;

/**
 * @author Sanjay
 *
 */
public interface LocationDao extends GenericDao<Location, Integer>{
	
	public List<Location> getLocationsByUserId(Integer userId);
	
}
