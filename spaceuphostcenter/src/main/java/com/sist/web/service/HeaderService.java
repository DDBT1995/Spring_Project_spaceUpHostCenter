package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.HeaderDao;
import com.sist.web.model.Host;

@Service("headerService")
public class HeaderService {
	private static Logger logger = LoggerFactory.getLogger(HeaderService.class);
	
	@Autowired
    private HeaderDao headerDao;
	// host 객체 선책(hostEmail)
    public Host hostSelect(String hostEmail) {
	Host host = null;

	try {
	    host = headerDao.hostSelect(hostEmail);
	} catch (Exception e) {
	    logger.error("[headerService] hostSelect Exception", e);
	}
	return host;
    }
}
