//
// Copyright 2010 Ettus Research LLC
//

#ifndef INCLUDED_LOCAL_DBOARDS_HPP
#define INCLUDED_LOCAL_DBOARDS_HPP

#include <usrp_uhd/usrp/dboard/base.hpp>

using namespace usrp_uhd::usrp::dboard;

/***********************************************************************
 * The basic boards:
 **********************************************************************/
class basic_rx : public rx_base{
public:
    static base::sptr make(ctor_args_t const& args){
        return base::sptr(new basic_rx(args));
    }
    basic_rx(ctor_args_t const& args);
    ~basic_rx(void);

    void rx_get(const wax::type &key, wax::type &val);
    void rx_set(const wax::type &key, const wax::type &val);
};

class basic_tx : public tx_base{
public:
    static base::sptr make(ctor_args_t const& args){
        return base::sptr(new basic_tx(args));
    }
    basic_tx(ctor_args_t const& args);
    ~basic_tx(void);

    void tx_get(const wax::type &key, wax::type &val);
    void tx_set(const wax::type &key, const wax::type &val);

};

#endif /* INCLUDED_LOCAL_DBOARDS_HPP */