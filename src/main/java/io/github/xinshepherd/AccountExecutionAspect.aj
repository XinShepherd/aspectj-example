package io.github.xinshepherd;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.CodeSignature;

/**
 * @author Fuxin
 * @since 2020/1/15 17:00
 */
public aspect AccountExecutionAspect {
    final int MIN_BALANCE = 10;
    static void println(String s){ System.out.println(s); }

    pointcut executionWithOther(): execution(boolean Account.withOther(int));

    boolean around(): executionWithOther(){
        println("Intercepted message: " +
                thisJoinPointStaticPart.getSignature().getName());
        println("in class: " +
                thisJoinPointStaticPart.getSignature().getDeclaringType().getName());
        printParameters(thisJoinPoint);
        println("Running original method: \n" );
        boolean result = proceed();
        println("  result: " + result );
        return result;
    }

    static private void printParameters(JoinPoint jp) {
        println("Arguments: " );
        Object[] args = jp.getArgs();
        String[] names = ((CodeSignature)jp.getSignature()).getParameterNames();
        Class[] types = ((CodeSignature)jp.getSignature()).getParameterTypes();
        for (int i = 0; i < args.length; i++) {
            println("  "  + i + ". " + names[i] +
                    " : " +            types[i].getName() +
                    " = " +            args[i]);
        }
    }

}
