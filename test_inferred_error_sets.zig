// With an inferred error set
pub fn add_inferred(comptime T: type, a: T, b: T) !T {
    const ov = @addWithOverflow(a, b);
    if (ov[1] != 0) return error.Overflow1;
    if (ov[0] != 0) return error.Overflow;
    return ov[0];
}

// With an explicit error set
pub fn add_explicit(comptime T: type, a: T, b: T) Error!T {
    const ov = @addWithOverflow(a, b);
    if (ov[1] != 0) return error.Overflow;
    return ov[0];
}

const Error = error{ Overflow, Overflow1 };
// comptime {
//     @compileLog(Error);
//     @compileLog(error.Overflow);
// }
const std = @import("std");

test "inferred error set" {
    try std.testing.expect(Error.Overflow == error.Overflow);

    if (add_inferred(u8, 255, 1)) |_| unreachable else |err| switch (err) {
        error.Overflow1 => {}, // ok
    }
    if (add_explicit(u8, 255, 1)) |_| unreachable else |err| switch (err) {
        error.Overflow => {
            std.log.warn("runs here {}", .{@src().line});
        }, // ok
        else => {
            std.log.warn("runs here {}", .{@src().line});
        },
    }
}
