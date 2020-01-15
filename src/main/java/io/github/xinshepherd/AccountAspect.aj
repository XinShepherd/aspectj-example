package io.github.xinshepherd;

/**
 * @author Fuxin
 * @since 2020/1/15 16:47
 */
public aspect AccountAspect {
    final int MIN_BALANCE = 10;

    pointcut callWithDraw(int amount, Account acc) :
            call(boolean Account.withdraw(int)) && args(amount) && target(acc);

    before(int amount, Account acc) : callWithDraw(amount, acc) {

    }

    boolean around(int amount, Account acc) :
            callWithDraw(amount, acc) {
        if (acc.balance < amount) {
            return false;
        }
        System.out.println(amount);
        return proceed(amount, acc);
    }

    after(int amount, Account balance) : callWithDraw(amount, balance) {

    }
}
