#include <iostream>
#include <dlib/bridge.h>
#include <dlib/type_safe_union.h>

void run_example4();

int main() {
    run_example4();
    return 0;
}

struct Foo {
    int value;
    std::string str;
};

void serialize (const Foo& item, std::ostream& out) {
    dlib::serialize(item.value, out);
    dlib::serialize(item.str, out);
}

void deserialize (Foo& item, std::istream& in) {
    dlib::deserialize(item.value, in);
    dlib::deserialize(item.str, in);
}

void run_example4() {
    //Motivation: Get status messages from bridges!
    // - Is it connected
    // - Who is connected
    
    typedef dlib::type_safe_union<int, Foo, dlib::bridge_status> tsu_type;
    dlib::pipe<tsu_type> in(4), out(4);
    dlib::pipe<dlib::bridge_status> b1_status(4);

    // Pipes to hold bridge_status messages
    dlib::bridge b1(dlib::listen_on_port(1234), dlib::transmit(out), dlib::receive(b1_status));

    // Create "Client side" bridge
    dlib::bridge b2(dlib::connect_to("localhost:1234"), dlib::receive(in));

    tsu_type msg;
    dlib::bridge_status bs;

    // Generate status message from each bridge, for connections
    b1_status.dequeue(bs);

    // std::boolalpha replaces return 1, with return true
    std::cout << "Bridge 1 status: is_connected: " << std::boolalpha << bs.is_connected << std::endl;
    std::cout << "Bridge 1 status: foreign_ip: " << std::boolalpha << bs.foreign_ip << std::endl;
    std::cout << "bridge 1 status: foreign_port: " << bs.foreign_port << std::endl;

    in.dequeue(msg);
    bs = msg.get<dlib::bridge_status>();
    std::cout << "bridge 2 status: is_connected: " << bs.is_connected << std::endl;
    std::cout << "bridge 2 status: foreign_ip:   " << bs.foreign_ip << std::endl;
    std::cout << "bridge 2 status: foreign_port: " << bs.foreign_port << std::endl;
    std::cout << "\n";

    // Send a simple int
    tsu_type msg_int;
    msg_int = 2;
    out.enqueue(msg_int);

    // Send a Foo struct with stuff
    Foo foo;
    foo.value = 2;
    foo.str = "foobar";

    tsu_type msg1;
    msg1 = foo;
    out.enqueue(msg1);
    
    //Assume you are on server side
    tsu_type recv;
    // If multiple things are sent in out.enqueue, in will not retrieve
    // next one before calling dequeue again.
    for (int i=0; i < 2; ++i) {
        in.dequeue(recv);

        if(recv.contains<int>())
            std::cout << "Heaven sent a int: " << msg.get<int>() << "\n \n";
        
        if(recv.contains<Foo>()) {
            std::cout << "Heaven sent a Foo struct:\n";
            std::cout << "Foo.value: " << msg.get<Foo>().value << std::endl;
            std::cout << "Foo.str: " << msg.get<Foo>().str << "\n \n";
        }
    }
}

