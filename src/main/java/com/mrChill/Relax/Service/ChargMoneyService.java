package com.mrChill.Relax.Service;

import com.mrChill.Relax.Dao.ChargMoneyDAO;
import com.mrChill.Relax.Dao.ResponseDAO;
import com.mrChill.Relax.Repository.ChargMoneyRepository;
import com.mrChill.Relax.entities.ChargMoney;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class ChargMoneyService {

	@Autowired
    ChargMoneyRepository cmr;

    public Double sumAmount (Date startDate, Date endDate){
        return cmr.sumAmount(startDate, endDate);
    }

    public ResponseDAO charg (ChargMoneyDAO chargMoneyDAO){
        ChargMoney chargMoneyEntity = chargMoneyDAO.convertToEntity();
        cmr.save(chargMoneyEntity);
        return new ResponseDAO(1,"Nạp tiền thành công.");
    }

    public Page<ChargMoney> searchChargList (Integer page , Integer perpage ,Date startDate, Date endDate){
        return cmr.findChargMoneyByChargDateIsBetween(PageRequest.of(page - 1, perpage), startDate,  endDate);
    }

    public Double sumAmountUser (Integer a,Date startDate, Date endDate){
        return cmr.sumAmountUser(a,startDate, endDate);
    }
    public Page<ChargMoney> searchChargListUser (Integer a,Integer page , Integer perpage ,Date startDate, Date endDate){
        return cmr.findChargMoneyByChargDateIsBetweenUser (a,PageRequest.of(page - 1, perpage), startDate,  endDate);
    }
}
