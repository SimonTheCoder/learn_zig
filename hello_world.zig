const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    std.debug.print("hello, world\n", .{});
    // @compileLog(@typeInfo(@TypeOf(print)));
}
