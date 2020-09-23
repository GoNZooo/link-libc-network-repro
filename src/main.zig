const std = @import("std");
const network = @import("network");

pub fn main() anyerror!void {
    try network.init();
    defer network.deinit();

    const address = network.Address{ .ipv4 = .{ .value = [_]u8{ 0, 0, 0, 0 } } };
    const port = 4000;
    const server_endpoint = network.EndPoint{
        .address = address,
        .port = port,
    };
    const socket = try network.Socket.create(network.AddressFamily.ipv4, network.Protocol.tcp);
    try socket.bind(server_endpoint);
    try socket.listen();

    const client_socket = try socket.accept();
    const remote_endpoint = try client_socket.getRemoteEndPoint();
    std.debug.print("Client: {}\n", .{remote_endpoint});
}
