import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';

class CartDetailFloatingButton extends StatelessWidget {
  const CartDetailFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<CartController>(  
          
                builder: (controller) => 
                Container(
                margin: const EdgeInsets.only(bottom: 56),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  height: 56,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 8, top: 8, bottom: 8),
                    child: Row(
                      children: [
                         Text(
                          "${controller.cartList.length} item(s)",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: VerticalDivider(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "NRs. ${controller.subTotal}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        //  const Padding(
                        //   padding: EdgeInsets.symmetric(vertical: 6),
                        //   child: VerticalDivider(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // Container(
                        //     height: 20,
                        //     width: 60,
                        //     decoration: BoxDecoration(
                        //       color: Colors.green.shade100,
                        //       borderRadius: BorderRadius.circular(6),
                        //     ),
                        //     child: Center(
                        //         child: Text(
                        //       "Rs. 50 off",
                        //       style: TextStyle(
                        //           color: Colors.green,
                        //           fontSize: 10,
                        //           fontWeight: FontWeight.w400),
                        //     ))),
                        const Spacer(),
                        InkWell( 
                          onTap: () { 
                              Navigator.pushNamed(context, RouteHelper.getCartRoute());
                          },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                "View Cart",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                           ),
             );
           
           
  }
}